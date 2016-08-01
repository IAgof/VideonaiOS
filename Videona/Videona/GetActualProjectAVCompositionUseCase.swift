//
//  GetActualProjectAVComposition.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class GetActualProjectAVCompositionUseCase: NSObject {
    static let sharedInstance = GetActualProjectAVCompositionUseCase()
    
    var videoTotalTime:CMTime = kCMTimeZero
    
    func getComposition() -> AVMutableComposition{
        videoTotalTime = kCMTimeZero
        
        let isMusicSet = Project.sharedInstance.isMusicSet
        
        // - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        let mixComposition = AVMutableComposition()
        
        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        var audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio,preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        let videosArray = Project.sharedInstance.getVideoList()
        // - Add assets to the composition
        for video in videosArray{
            // 2 - Get Video asset
            let videoURL: NSURL = NSURL.init(fileURLWithPath: video.getMediaPath())
            let videoAsset = AVAsset.init(URL: videoURL)
            
            
            do {
                try videoTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration),
                                               ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeVideo)[0] ,
                                               atTime: videoTotalTime)
                
                if isMusicSet == false {
                    try audioTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration),
                                                   ofTrack: videoAsset.tracksWithMediaType(AVMediaTypeAudio)[0] ,
                                                   atTime: videoTotalTime)
                }
                
                Utils().debugLog("el tiempo total del video es: \(videoTotalTime.seconds)")
                videoTotalTime = CMTimeAdd(videoTotalTime, videoAsset.duration)
            } catch _ {
                //                Utils().debugLog("Error trying to create videoTrack")
                //                completionHandler("Error trying to create videoTrack",0.0)
            }
        }
        
        if isMusicSet{
            // 3.2 - Audio track
            // Get Audio asset
            let audioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(Project.sharedInstance.getMusic().getMusicResourceId(), ofType: "m4a")!)
            let audioAsset = AVAsset.init(URL: audioURL)
            
            audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: 0)
            do {
                try audioTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoTotalTime),
                                               ofTrack: audioAsset.tracksWithMediaType(AVMediaTypeAudio)[0] ,
                                               atTime: kCMTimeZero)
            } catch _ {
                Utils().debugLog("Error trying to create audioTrack")
            }
        }

        
        return mixComposition
    }
}