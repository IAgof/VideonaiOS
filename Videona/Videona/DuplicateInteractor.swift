//
//  DuplicateInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class DuplicateInteractor: NSObject,DuplicateInteractorInterface {
    var delegate:DuplicateInteractorDelegate?
    
    var videoPosition:Int?{
        didSet{
            setStartAndStopParams()
        }
    }
    
    var startTime:Float = 0.0
    var stopTime:Float = 0.0
    var mediaPath:String = ""
    
    func setVideoPosition(position: Int) {
        self.videoPosition = position
    }
    
    func setStartAndStopParams(){
        let video = Project.sharedInstance.getVideoList()[videoPosition!]
        
        self.startTime = Float(video.getStartTime())
        self.stopTime = Float(video.getStopTime())
        self.mediaPath = video.getMediaPath()
    }
    
    func setUpComposition(videoSelectedIndex: Int,
                          completion:(AVMutableComposition)->Void) {
        guard mediaPath != "" else{
            return
        }
        
        let mixComposition = AVMutableComposition()
        
        let videoTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeVideo,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        let audioTrack = mixComposition.addMutableTrackWithMediaType(AVMediaTypeAudio,
                                                                     preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        // 2 - Get Video asset
        let videoURL: NSURL = NSURL.init(fileURLWithPath: self.mediaPath)
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
        
        completion(mixComposition)
    }
    
    func setDuplicateVideoToProject(numberDuplicates: Int) {
        
        for i in 1...(numberDuplicates - 1){
            let video = Project.sharedInstance.getVideoList()[videoPosition!].copy() as? Video

            AddVideoToProjectUseCase.sharedInstance.add(video!,
                                                        position: videoPosition!)
        }
    }
    
    func getThumbnail(frame:CGRect) {
        let asset = AVURLAsset(URL: NSURL(fileURLWithPath: mediaPath), options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        var cgImage:CGImage?
        do {
            cgImage =  try imgGenerator.copyCGImageAtTime(CMTime.init(value: 1, timescale: 10), actualTime: nil)
            print("Thumbnail image gets okay")
            
            // !! check the error before proceeding
            let thumbnail = UIImage(CGImage: cgImage!)

            delegate?.setThumbnail(thumbnail)

        } catch {
            print("Thumbnail error \nSomething went wrong!")
        }
    }
}