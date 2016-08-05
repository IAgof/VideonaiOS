//
//  SplitInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class SplitInteractor: NSObject,SplitInteractorInterface {
    var delegate:SplitInteractorDelegate?
    
    var videoPosition:Int?
    
    func setVideoPosition(position: Int) {
        self.videoPosition = position
    }
    
    func getVideoParams() {
        let video = Project.sharedInstance.getVideoList()[videoPosition!]
        
        delegate?.settSplitValue(Float(video.getStopTime()/2))
        delegate?.setMaximumValue(Float(video.getDuration()))
    }
    
    func setUpComposition(completion:(AVMutableComposition)->Void) {
        if videoPosition == nil {
            return
        }
        
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
            
            try videoTrack.insertTimeRange(CMTimeRangeMake(startTime, stopTime),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
            try audioTrack.insertTimeRange(CMTimeRangeMake(startTime, stopTime),
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
        } catch _ {
            Utils().debugLog("Error trying to create videoTrack")
            //                completionHandler("Error trying to create videoTrack",0.0)
        }
        completion(mixComposition)
    }
}