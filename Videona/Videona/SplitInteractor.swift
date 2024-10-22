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
        
        let videoDuration = (video.getStopTime() - video.getStartTime())
        
        delegate?.settSplitValue(Float(videoDuration/2))
        delegate?.setMaximumValue(Float(videoDuration))
    }
    
    func setUpComposition(completion:(AVMutableComposition)->Void) {
        var videoTotalTime:CMTime = kCMTimeZero
        
        guard let videoPos = videoPosition else {
            return
        }
        
        let video = Project.sharedInstance.getVideoList()[videoPos]
        
        let mixComposition = AVMutableComposition()
        
        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        let audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        // 2 - Get Video asset
        let videoURL: NSURL = NSURL.init(fileURLWithPath: video.getMediaPath())
        let videoAsset = AVAsset.init(URL: videoURL)
        
        do {
            let startTime = CMTimeMake(Int64(video.getStartTime() * 1000), 1000)
            let stopTime = CMTimeMake(Int64(video.getStopTime() * 1000), 1000)
            
            let timeRangeInsert = CMTimeRangeMake(startTime, stopTime)
            
            try videoTrack.insertTimeRange(timeRangeInsert,
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                           atTime: kCMTimeZero)
            
            try audioTrack.insertTimeRange(timeRangeInsert,
                                           ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeAudio)[0] ,
                                           atTime: kCMTimeZero)
            videoTotalTime = CMTimeAdd(videoTotalTime, (stopTime - startTime))
            
            mixComposition.removeTimeRange(CMTimeRangeMake((videoTotalTime), (stopTime + videoTotalTime)))
        } catch _ {
            Utils().debugLog("Error trying to create videoTrack")
            //                completionHandler("Error trying to create videoTrack",0.0)
        }
        
        completion(mixComposition)
    }
   
    func setSplitVideosToProject(splitTime:Double){
        var videoList = Project.sharedInstance.getVideoList()
        if videoList.indices.contains(videoPosition!){
            if (videoPosition != nil) { //Create a copy and add to the list
                let videoCopy = videoList[videoPosition!].copy() as? Video
                
                videoCopy?.setStartTime((videoCopy?.getStartTime())! + splitTime)
                videoCopy?.setIsSplit(true)
                
                //Add video to the Project video list
                
                videoList.insert(videoCopy!, atIndex: (videoPosition! + 1))
                
                let video = videoList[videoPosition!]
                
                video.setStopTime(video.getStartTime() + splitTime)
                video.setIsSplit(true)
            }
        }
        
        Project.sharedInstance.setVideoList(videoList)
    }
}