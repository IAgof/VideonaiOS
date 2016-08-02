//
//  TrimInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 2/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class TrimInteractor: NSObject,TrimInteractorInterface {
    var delegate:TrimInteractorDelegate?
    
    var videoSelected:Video?
    var videoPosition:Int?

    func setVideoPosition(position: Int) {
        self.videoPosition = position
    }
    
    func getVideoParams() {
        let video = Project.sharedInstance.getVideoList()[videoPosition!]

        delegate?.setLowerValue(Float(video.getStartTime()))
        delegate?.setUpperValue(Float(video.getStopTime()))
    }
    
    func setParametersOnVideoSelectedOnProjectList(startTime:Float,
                                                   stopTime:Float){
        let videoList = Project.sharedInstance.getVideoList()
        
        videoList[videoPosition!].setStopTime(Double(stopTime))
        videoList[videoPosition!].setStartTime(Double(startTime))
        
        Project.sharedInstance.setVideoList(videoList)
    }
    
    func setUpComposition(videoSelectedIndex: Int,completion:(AVMutableComposition)->Void) {
        let video = Project.sharedInstance.getVideoList()[videoPosition!]
        
        let mixComposition = AVMutableComposition()

        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        let audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        // 2 - Get Video asset
        let videoURL: NSURL = NSURL.init(fileURLWithPath: video.getMediaPath())
        let videoAsset = AVAsset.init(URL: videoURL)
        
        do {
            let stopTime = CMTimeMake(Int64(video.getStopTime() * 1000), 1000)
            let startTime = CMTimeMake(Int64(video.getStartTime() * 1000), 1000)
            
            try videoTrack.insertTimeRange(CMTimeRangeMake(startTime,  stopTime),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
            try audioTrack.insertTimeRange(CMTimeRangeMake(startTime,  stopTime),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
        } catch _ {
            Utils().debugLog("Error trying to create videoTrack")
            //                completionHandler("Error trying to create videoTrack",0.0)
        }
        
        completion(mixComposition)
    }
}