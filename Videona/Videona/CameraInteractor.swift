//
//  CameraInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 25/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage
import AVFoundation

class CameraInteractor{
    var videoCamera:GPUImageVideoCamera
    var filter:GPUImageFilter
//    var movieWriter: GPUImageMovieWriter sacar a otro Interactor?
    var displayView: GPUImageView
    var imageView: UIImageView?
    
    let resolution = AVCaptureSessionPreset1280x720
    
    var sourceImageGPUUIElement: GPUImageUIElement?
    init(display:GPUImageView){
        videoCamera = GPUImageVideoCamera(sessionPreset: resolution, cameraPosition: .Back)
        videoCamera.outputImageOrientation = .LandscapeLeft
        displayView = display
        
        filter = GPUImageFilter()
        
        videoCamera.addTarget(filter)
        
        self.addBlendUIElementAtInit()
        
        videoCamera.startCameraCapture()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CameraInteractor.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    @objc func checkOrientation(){
        if videoCamera.outputImageOrientation == .LandscapeLeft{
            videoCamera.outputImageOrientation = .LandscapeRight
        }else{
            videoCamera.outputImageOrientation = .LandscapeLeft
        }
    }
    
    func addFilter(newFilter:GPUImageFilter){
        AddFilterInteractor().addFilter(filter, newFilter: newFilter, display: displayView)
        
        filter = newFilter
    }
    func addBlendFilter(image:UIImage){
//        let blendFilter = GPUImageAlphaBlendFilter()
//        
//        AddFilterInteractor().addBlendFilter(filter, blendFilter: blendFilter ,blendImage: image, display: displayView)
//        
//        filter = blendFilter
        
        
    }
    
    func addBlendUIElementAtInit(){
        let blendFilter = GPUImageAlphaBlendFilter()
        blendFilter.mix = 0.5
        let imageView = UIImageView.init(frame: displayView.frame)
        
        sourceImageGPUUIElement = GPUImageUIElement(view: imageView)
        
        filter.addTarget(blendFilter)
        sourceImageGPUUIElement!.addTarget(blendFilter)
        
        blendFilter.addTarget(displayView)
        
        filter = blendFilter
        
        filter.frameProcessingCompletionBlock = { filter, time in
            self.sourceImageGPUUIElement!.update()
        }
    }
    
    func changeFilter(){
        ChangeFilterInteractor().changeFilter(filter, newFilter: GPUImageSwirlFilter(), display: displayView)
    }
    
    func removeFilters(){
        let newBaseFilter = GPUImageFilter()
        RemoveFilterInteractor().removeFilter(newBaseFilter, videoCamera: videoCamera, display: displayView)
        filter = newBaseFilter
        filter.useNextFrameForImageCapture()
    }
}