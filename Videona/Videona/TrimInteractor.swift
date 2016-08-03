//
//  TrimInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 2/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class TrimInteractor: NSObject,TrimInteractorInterface {
    var delegate:TrimInteractorDelegate?
    
    var videoPosition:Int?
    var videoSelected:Video?
    
    var startTime:Float = 0.0
    var stopTime:Float = 0.0
    
    func setVideoPosition(position: Int) {
        self.videoPosition = position
    }
    
    func getVideoParams() {
        let video = Project.sharedInstance.getVideoList()[videoPosition!]

        delegate?.setLowerValue(Float(video.getStartTime()))
        delegate?.setUpperValue(Float(video.getStopTime()))
        delegate?.setMaximumValue(Float(video.getDuration()))
    }
    
    func setParametersOnVideoSelectedOnProjectList(startTime:Float,
                                                   stopTime:Float){
        let videoList = Project.sharedInstance.getVideoList()
        
        videoList[videoPosition!].setStopTime(Double(stopTime))
        videoList[videoPosition!].setStartTime(Double(startTime))
        
        Project.sharedInstance.setVideoList(videoList)
    }
    
    func setParametersOnVideoSelected(startTime:Float,
                                      stopTime:Float){
        videoSelected = Project.sharedInstance.getVideoList()[videoPosition!].copy() as? Video
        
//        videoSelected!.setStopTime(Double(stopTime))
//        videoSelected!.setStartTime(Double(startTime))
        
        self.startTime = startTime
        self.stopTime = stopTime
    }
    
    func setUpComposition(videoSelectedIndex: Int,
                          completion:(AVMutableComposition)->Void) {
        guard let video = videoSelected else{
            return
        }
        
        let mixComposition = AVMutableComposition()

        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        let audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        // 2 - Get Video asset
        let videoURL: NSURL = NSURL.init(fileURLWithPath: video.getMediaPath())
        let videoAsset = AVAsset.init(URL: videoURL)
        
        do {
            let stopTime = CMTimeMake(Int64(self.stopTime * 1000), 1000)
            let startTime = CMTimeMake(Int64(self.startTime * 1000), 1000)
            
            try videoTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
            try audioTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
            mixComposition.removeTimeRange(CMTimeRangeMake(kCMTimeZero, startTime))
            mixComposition.removeTimeRange(CMTimeRangeMake(stopTime, videoAsset.duration))
        } catch _ {
            Utils().debugLog("Error trying to create videoTrack")
            //                completionHandler("Error trying to create videoTrack",0.0)
        }
        
        videoSelected = nil
        completion(mixComposition)
    }
}