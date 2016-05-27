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
    var maskFilterToOutput:GPUImageFilter
//    var movieWriter: GPUImageMovieWriter sacar a otro Interactor?
    var displayView: GPUImageView
    var imageView:UIImageView
    let resolution = AVCaptureSessionPreset1280x720
    
    var sourceImageGPUUIElement: GPUImageUIElement?
    init(display:GPUImageView){
        videoCamera = GPUImageVideoCamera(sessionPreset: resolution, cameraPosition: .Back)
        videoCamera.outputImageOrientation = .LandscapeLeft
        displayView = display
        imageView = UIImageView.init(frame: displayView.frame)
        
        filter = GPUImageFilter()
        maskFilterToOutput = GPUImageFilter()
        
        videoCamera.addTarget(filter)

        self.addBlendFilterAtInit()
        
        videoCamera.startCameraCapture()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CameraInteractor.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func addBlendFilterAtInit(){
        let blendFilter = GPUImageAlphaBlendFilter()
        blendFilter.mix = 0.5
        filter.removeAllTargets()
        
        let image = UIImage.init(named: "filter_free")
        imageView.image = image
        
        sourceImageGPUUIElement = GPUImageUIElement(view: imageView)
        
        filter.addTarget(blendFilter)
        sourceImageGPUUIElement!.addTarget(blendFilter)
        
        blendFilter.addTarget(maskFilterToOutput)
        maskFilterToOutput.addTarget(displayView)
        
        filter.frameProcessingCompletionBlock = { filter, time in
            self.sourceImageGPUUIElement!.update()
        }
    }
    
    @objc func checkOrientation(){
        if videoCamera.outputImageOrientation == .LandscapeLeft{
            videoCamera.outputImageOrientation = .LandscapeRight
        }else{
            videoCamera.outputImageOrientation = .LandscapeLeft
        }
    }
    
    func changeBlendImage(image:UIImage){
        imageView.image = image
    }

    func changeFilter(newFilter:GPUImageFilter){
        ChangeFilterInteractor().changeFilter(maskFilterToOutput, newFilter: newFilter, display: displayView)
    }
    
    func addFilter(newFilter:GPUImageFilter){
        AddFilterInteractor().addFilter(maskFilterToOutput, newFilter: newFilter, display: displayView)
        
        maskFilterToOutput = newFilter
    }
    
    func removeFilters(){
        RemoveFilterInteractor().removeFilter(maskFilterToOutput, imageView: imageView, display: displayView)
    }
}