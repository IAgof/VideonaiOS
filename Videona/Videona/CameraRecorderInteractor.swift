//
//  CameraRecorderInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 30/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class CameraRecorderInteractor{

    var filterToWriter :GPUImageFilter?
    var movieWriter: GPUImageMovieWriter?
    var clipsArray:[String] = []
    var videoCamera: GPUImageVideoCamera?
    
    func recordVideo(){

        let clipPath = getNewClipPath()
        self.clipsArray.append(clipPath)

        let clipURL = NSURL.init(fileURLWithPath: clipPath)
        
        Utils().debugLog("PathToMovie: \(clipPath)")
        self.movieWriter = GPUImageMovieWriter.init(movieURL: clipURL, size: CGSizeMake(640,480))
        self.movieWriter!.encodingLiveVideo = true
        self.videoCamera?.audioEncodingTarget = movieWriter
        
        self.movieWriter!.startRecording()
        
        Utils().debugLog("Recording movie starts")
        filterToWriter?.addTarget(movieWriter)
    }
    
    func stopRecordVideo(){ //Stop Recording
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            Utils().debugLog("Starting to stop record video")
            
            self.filterToWriter!.removeAllTargets()
            
//            self.videoCamera.audioEncodingTarget = nil
            
            self.movieWriter!.finishRecordingWithCompletionHandler{ () -> Void in
                
                Utils().debugLog("Stop recording video")
                
                ClipsAlbum.sharedInstance.saveVideo(NSURL.init(fileURLWithPath: self.clipsArray[(self.clipsArray.count - 1) ]))
                self.movieWriter!.endProcessing()
                self.movieWriter = nil
            }
        }
    }
    
    func setInput(input: GPUImageInput){
        self.filterToWriter = input as? GPUImageFilter
        if movieWriter != nil{
            filterToWriter?.addTarget(movieWriter)
        }
    }
    func setVideoCamera(videoCamera: GPUImageVideoCamera){
        self.videoCamera = videoCamera
    }

    func getNewClipPath()->String{
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path =  path + "/\(Utils().giveMeTimeNow())videonaClip.m4v"
        return path
    }
    
    func getClipsArray() -> [String] {
        return clipsArray
    }
    func resetClipsArray(){
        clipsArray = []
    }
}