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

class CameraInteractor:CameraRecorderDelegate{
    //MARK: - VIPER
    var cameraDelegate:CameraInteractorDelegate
    var cameraRecorder = CameraRecorderInteractor()
    
    //MARK: - Camera variables
    var videoCamera:GPUImageVideoCamera
    var filter:GPUImageFilter
    var maskFilterInput:GPUImageFilter
    var maskFilterOutput:GPUImageFilter
    var displayView: GPUImageView
    var sourceImageGPUUIElement: GPUImageUIElement?
    var imageView:UIImageView
    //    var movieWriter: GPUImageMovieWriter sacar a otro Interactor?

    let resolution = AVCaptureSessionPreset1280x720
    
    var isRearCamera:Bool = false
    
    var isRecording: Bool = false{
        didSet {
            if isRecording {
                self.setInputToWriter()
            }else{
                self.stopRecordVideo()
            }
        }
    }
    
    //MARK: - Init
    init(display:GPUImageView, cameraDelegate: CameraInteractorDelegate){
        self.cameraDelegate = cameraDelegate
        videoCamera = GPUImageVideoCamera(sessionPreset: resolution, cameraPosition: .Back)
        videoCamera.outputImageOrientation = .LandscapeLeft
        displayView = display
        imageView = UIImageView.init(frame: displayView.frame)
        
        filter = GPUImageFilter()
        maskFilterInput = GPUImageFilter()
        maskFilterOutput = GPUImageFilter()
        
        videoCamera.addTarget(filter)

        self.addBlendFilterAtInit()
        
        videoCamera.startCameraCapture()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CameraInteractor.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    func getClipsArray() -> [String] {
        return cameraRecorder.getClipsArray()
    }
    
    func resetClipsArray(){
        cameraRecorder.resetClipsArray()
    }
    //MARK: - Orientation
    @objc func checkOrientation(){
        if UIDevice.currentDevice().orientation == .LandscapeLeft{
            videoCamera.outputImageOrientation = .LandscapeRight
        }else{
            videoCamera.outputImageOrientation = .LandscapeLeft
        }
    }
    
    func rotateCamera(){
        self.videoCamera.rotateCamera()
        
        if self.isRearCamera {
            self.isRearCamera = false
            cameraDelegate.cameraRear()
        }else{
            self.isRearCamera = true
            cameraDelegate.cameraFront()
            if(FlashInteractor().isFlashTurnOn()){
                cameraDelegate.flashOff()
            }
        }
    }
    
    //MARK: - Filters functions
    func addBlendFilterAtInit(){
        let blendFilter = GPUImageAlphaBlendFilter()
        blendFilter.mix = 0.5
        filter.removeAllTargets()
        
        let image = UIImage.init(named: "filter_free")
        imageView.image = image
        
        sourceImageGPUUIElement = GPUImageUIElement(view: imageView)
        
        filter.addTarget(blendFilter)
        sourceImageGPUUIElement!.addTarget(blendFilter)
        
        blendFilter.addTarget(maskFilterInput)
        
        maskFilterInput.addTarget(maskFilterOutput)
        
        maskFilterOutput.addTarget(displayView)
        
        filter.frameProcessingCompletionBlock = { filter, time in
            self.sourceImageGPUUIElement!.update()
        }
    }

    func changeBlendImage(image:UIImage){
        imageView.image = image
    }

    func changeFilter(newFilter:GPUImageFilter){
        ChangeFilterInteractor().changeFilter(maskFilterInput, newFilter: newFilter, display: displayView)
   
        maskFilterOutput = newFilter
        self.setInputToWriter()
    }
    
    func addFilter(newFilter:GPUImageFilter){
        AddFilterInteractor().addFilter(maskFilterInput, newFilter: newFilter, display: displayView)
        
        maskFilterOutput = newFilter
    }
    
    func removeFilters(){
        RemoveFilterInteractor().removeFilter(maskFilterInput, imageView: imageView, display: displayView)
        
        self.reSetOutputIfIsRecording()
    }
    
    func removeShaders(){
        RemoveFilterInteractor().removeShader(maskFilterInput, display: displayView)
        
        self.reSetOutputIfIsRecording()
    }
    
    func reSetOutputIfIsRecording() {
        maskFilterOutput = GPUImageFilter()
        
        maskFilterInput.addTarget(maskFilterOutput)
        
        maskFilterOutput.addTarget(displayView)
        
        if isRecording {
            setInputToWriter()
        }
    }
    
    func removeOverlay(){
        RemoveFilterInteractor().removeOverlay(imageView)
    }
    func setInputToWriter(){
        print("set Input To Writer")
        
        print("\n maskFilterOutput targets \n \(maskFilterOutput.targets())\n\n\n")

            let maskFilterToRecord = GPUImageFilter()
            maskFilterOutput.addTarget(maskFilterToRecord)
            
            cameraRecorder.setInput(maskFilterToRecord)
    }

    //MARK: - Recorder delegate
    func startRecordVideo(completion:(String)->Void){
        print("Start record video")

        cameraRecorder.setVideoCamera(videoCamera)
        cameraRecorder.setResolution(resolution)
        
        cameraRecorder.recordVideo({answer in
            print("Camera Interactor \(answer)")
            completion(answer)
        })
    }
    
    func setIsRecording(isRecording:Bool){
        self.isRecording = isRecording
    }

    func stopRecordVideo() {
        for maskFilter in maskFilterOutput.targets(){
            if maskFilter.isKindOfClass(GPUImageFilter){
                maskFilterOutput.removeTarget(maskFilter as! GPUImageInput)
            }
        }
        cameraRecorder.stopRecordVideo()
    }
}