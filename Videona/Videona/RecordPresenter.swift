//
//  RecordPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class RecordPresenter: NSObject, RecordPresenterInterface,FilterListDelegate,CameraInteractorDelegate,TimerInteractorDelegate{
    
    //MARK: - Variables VIPER
    var controller: RecordController?
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    var cameraInteractor: CameraInteractor?
    var timerInteractor: TimerInteractor?

    //MARK: - Constants
    var colorFilterViewIsShowin = false
    var shaderFilterViewIsShowin = false
    var isRecording = false

    //MARK: - Event handler
    func viewDidLoad(displayView:GPUImageView){
        
        controller?.configureView()
        cameraInteractor = CameraInteractor(display: displayView,cameraDelegate: self)
    }
    
    func viewWillDisappear() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if self.isRecording{
                self.stopRecord() 
            }
        })
    }
    
    func pushSettings() {
        print("Record presenter pushSettings")
        settingsWireframe?.presentSettingsInterfaceFromViewController(controller!)
    }
    
    func pushShare() {
        controller?.createAlertWaitToExport()
        self.hideAnyFilterList()
        
        print("Record presenter pushShare")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let exporter = ExporterInteractor.init(videosArray: (self.cameraInteractor?.getClipsArray())!)
            exporter.exportVideos({ exportPath in
                print("Export path response = \(exportPath)")
                
                self.controller?.dissmissAlertWaitToExport({
                    //wait to remove alert to present new Screeen
                    self.shareWireframe?.presentShareInterfaceFromViewController(self.controller!,videoPath: exportPath)
                })
            })
        });
    }
    
    func navigateToShareController(){
        
    }
    func pushFlash() {
        let flashState = FlashInteractor().switchFlashState()
        controller?.showFlashOn(flashState)
    }
    
    func pushRecord() {
        if isRecording {
            self.stopRecord()
        }else{
            self.startRecord()
        }
    }
    func startRecord(){
        controller?.recordButtonEnable(false)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.cameraInteractor?.setIsRecording(true)
            
            self.cameraInteractor?.startRecordVideo({answer in
                print("Record Presenter \(answer)")
                self.controller?.recordButtonEnable(true)
            })
            
            dispatch_async(dispatch_get_main_queue(), {
                // update some UI
                self.controller?.showRecordButton()
                self.controller?.disableShareButton()
            });
        });
        isRecording = true
        
        self.startTimer()
    }
    
    func stopRecord(){
        isRecording = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // do some task
            self.cameraInteractor?.setIsRecording(false)
            
            let videosArray = self.cameraInteractor?.getClipsArray()
            let thumb = ThumbnailInteractor.init(videosArray: videosArray!).getThumbnailImageView()
            dispatch_async(dispatch_get_main_queue(), {
                // update some UI
                self.controller?.showRecordedVideoThumb(thumb)
                self.controller?.showNumberVideos((videosArray?.count)!)
                self.controller?.showStopButton()
                self.controller?.enableShareButton()
            });
        });
        
        self.stopTimer()
    }
    func pushRotateCamera() {
        cameraInteractor!.rotateCamera()
    }

    func showWarningOrientationImage(){
        controller?.lockScreenRotation()
    }
    
    func hideWarningOrientationImage(){
        controller?.unlockScreenRotation()
    }
    
    //MARK: - FilterList delegate
    func hideAnyFilterList() {
        if(shaderFilterViewIsShowin || colorFilterViewIsShowin){
            self.recordWireframe?.dismissFilterListInterface()
            
            shaderFilterViewIsShowin = false
            colorFilterViewIsShowin = false
            
            controller?.showOverlayOnTop(shaderFilterViewIsShowin)
            controller?.showShadersOnTop(colorFilterViewIsShowin)
        }
    }
    
    func pushShowHideColorFilters() {
        if(shaderFilterViewIsShowin){
            shaderFilterViewIsShowin = false
            
            self.recordWireframe?.dismissFilterListInterface()
            //Wait to hide filterlist
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), {
                self.recordWireframe?.presentColorFilterListInterface()
                
            });
            
            self.colorFilterViewIsShowin = true
            
            controller?.showOverlayOnTop(true)
            controller?.showShadersOnTop(false)
            
            return
        }else if(colorFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface()
            controller?.showOverlayOnTop(false)
            colorFilterViewIsShowin = false
            return
        }else{
            recordWireframe?.presentColorFilterListInterface()
            controller?.showOverlayOnTop(true)
            colorFilterViewIsShowin = true
            return
        }
    }
    
    func pushShowHideShaderFilters() {
        if(colorFilterViewIsShowin){
            colorFilterViewIsShowin = false
            recordWireframe?.dismissFilterListInterface()
            //Wait to hide filterlist
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), {
                self.recordWireframe?.presentShaderFilterListInterface()
            });
            self.shaderFilterViewIsShowin = true
            controller?.showOverlayOnTop(false)
            controller?.showShadersOnTop(true)
            return
        }else if(shaderFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface()
            
            controller?.showShadersOnTop(false)
            shaderFilterViewIsShowin = false
            return
        }else{
            recordWireframe?.presentShaderFilterListInterface()
            controller?.showShadersOnTop(true)
            shaderFilterViewIsShowin = true
            return
        }
    }
    
    func setFiltersOnView(filterName: String) {
        let filterDic = effectDictionary
        
        if (filterDic[filterName]?.indexForKey(FilterType.Blend)) != nil{
            print("setFiltersOnView   blendFilter")
            cameraInteractor?.changeBlendImage(UIImage.init(named: filterName.lowercaseString)!)
            
        }else if ((filterDic[filterName]?.indexForKey(FilterType.SingleInput)) != nil){
            print("setFiltersOnView   SingleInputFilter")
            let newFilter = filterDic[filterName]?[FilterType.SingleInput]!
            cameraInteractor?.changeFilter(newFilter! as! GPUImageFilter)
            
        }else if (filterDic[filterName]?.indexForKey(FilterType.Shader)) != nil{
            print("setFiltersOnView   Shader")
            let newFilter = GPUImageFilter(fragmentShaderFromFile: filterName)
            cameraInteractor?.changeFilter(newFilter!)
            
        }else if (filterDic[filterName]?.indexForKey(FilterType.Other)) != nil{
            print("setFiltersOnView   Other")
            cameraInteractor?.removeFilters()
            
        }
    }
    
    func removeFilter(filterName: String) {
        let filterDic = effectDictionary
        
        if (filterDic[filterName]?.indexForKey(FilterType.Blend)) != nil{
            print("setFiltersOnView   blendFilter")
            cameraInteractor?.removeOverlay()
            
        }else if ((filterDic[filterName]?.indexForKey(FilterType.SingleInput)) != nil){
            print("setFiltersOnView   SingleInputFilter")
            cameraInteractor?.removeShaders()
            
        }else if (filterDic[filterName]?.indexForKey(FilterType.Shader)) != nil{
            print("setFiltersOnView   Shader")
            cameraInteractor?.removeShaders()
            
        }else if (filterDic[filterName]?.indexForKey(FilterType.Other)) != nil{
            print("setFiltersOnView   Other")
            cameraInteractor?.removeFilters()
        }
    }
    
    func resetRecorder() {
        controller?.hideRecordedVideoThumb()
        controller?.disableShareButton()
        
        cameraInteractor?.resetClipsArray()
        cameraInteractor?.removeFilters()
    }
    
    //MARK: - Camera delegate
    func flashOn() {
        controller?.showFlashOn(true)
    }
    func flashOff() {
        controller?.showFlashOn(false)
    }
    func cameraRear() {
        controller?.showBackCameraSelected()
        controller?.showFlashSupported(true)
    }
    func cameraFront() {
        controller?.showFrontCameraSelected()
        controller?.showFlashSupported(false)
    }
    
    func startTimer() {
        controller?.showChronometer()
        
        timerInteractor = TimerInteractor()
        timerInteractor!.setDelegate(self)

        timerInteractor?.start()
    }
    
    func stopTimer() {
        controller?.hideChronometer()
        
        timerInteractor?.stop()
    }
    
    //MARK: - Timer delegate
    func updateTimer(time: String) {
        controller?.updateChronometer(time)
    }

}