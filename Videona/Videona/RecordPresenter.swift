//
//  RecordPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class RecordPresenter: NSObject
    , RecordPresenterInterface
    ,FilterListDelegate
    ,CameraInteractorDelegate
,TimerInteractorDelegate{
    
    //MARK: - Variables VIPER
    var controller: RecordViewInterface?
    var cameraInteractor: CameraInteractorInterface?
    var timerInteractor: TimerInteractorInterface?
    
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    //MARK: - Constants
    var colorFilterViewIsShowin = false
    var shaderFilterViewIsShowin = false
    var isRecording = false
    
    struct EffectOnView {
        var effectName:String
        var effectActive:Bool
    }
    //MARK: - Variables
    var overlayActive:EffectOnView = EffectOnView(effectName: "", effectActive: false)
    var shaderActive:EffectOnView = EffectOnView(effectName: "", effectActive: false)
    
    //MARK: - Event handler
    func viewDidLoad(displayView:GPUImageView){
        
        controller?.configureView()
        cameraInteractor = CameraInteractor(display: displayView,cameraDelegate: self)
        
        self.checkFlashAvaliable()
    }
    
    func viewWillDisappear() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.cameraInteractor?.stopCamera()
            if self.isRecording{
                self.stopRecord()
            }
            FlashInteractor().turnOffWhenViewWillDissappear()
            dispatch_async(dispatch_get_main_queue(), {
                self.controller?.showFlashOn(false)
            })
        })
    }
    
    func viewWillAppear() {
        cameraInteractor!.setResolution()
        cameraInteractor?.startCamera()
        
        controller?.forceOrientation()
    }
    
    
    func pushSettings() {
        print("Record presenter pushSettings")
        self.trackSettingsPushed()
        settingsWireframe?.presentSettingsInterfaceFromViewController((controller?.getController())!)
    }
    
    func pushShare() {
        controller?.createAlertWaitToExport()
        controller?.getTrackerObject().mixpanel.timeEvent(AnalyticsConstants().VIDEO_EXPORTED);
        
        self.hideAnyFilterList()
        
        print("Record presenter pushShare")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let exporter = ExporterInteractor.init()
            exporter.exportVideos({ exportPath,videoTotalTime in
                print("Export path response = \(exportPath)")
                self.trackExported(videoTotalTime)
                
                self.controller?.dissmissAlertWaitToExport({
                    //wait to remove alert to present new Screeen
                    self.shareWireframe?.presentShareInterfaceFromViewController((self.controller?.getController())!,
                        videoPath: exportPath,
                        numberOfClips: Project.sharedInstance.numberOfClips())
                })
            })
        });
    }
    
    func pushFlash() {
        let flashState = FlashInteractor().switchFlashState()
        controller?.showFlashOn(flashState)
        self.trackFlash(flashState)
    }
    
    func pushRecord() {
        if isRecording {
            self.stopRecord()
        }else{
            self.startRecord()
        }
    }
    
    func startRecord(){
        self.trackStartRecord()
        
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
            })
        })
        isRecording = true
        
        self.startTimer()
    }
    
    func stopRecord(){
        self.trackStopRecord()
        
        isRecording = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // do some task
            self.cameraInteractor?.setIsRecording(false)
            
            let videoPath = Project.sharedInstance.getVideoList()[Project.sharedInstance.numberOfClips() - 1].getMediaPath()
            
            let thumb = ThumbnailInteractor.init(videoPath: videoPath,
                diameter: (self.controller?.getRecordButtonSize())!).getThumbnailImageView()
            dispatch_async(dispatch_get_main_queue(), {
                // update some UI
                self.controller?.showRecordedVideoThumb(thumb)
                self.controller?.showNumberVideos(Project.sharedInstance.numberOfClips())
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
    
    func thumbnailHasTapped() {
        recordWireframe?.presentEditorRoomInterface()
    }
    
    func displayHasTapped(tapGesture:UIGestureRecognizer){
        cameraInteractor?.cameraViewTapAction(tapGesture)
    }
    
    func displayHasPinched(pinchGesture: UIPinchGestureRecognizer) {
        cameraInteractor?.zoom(pinchGesture)
    }
    
    func checkFlashAvaliable(){
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if device.hasTorch == false{
            controller?.showFlashSupported(false)
        }

    }
    
    //MARK: - Track Events
    func trackFlash(flashState:Bool){
        let tracker = controller?.getTrackerObject()
        if flashState {
            tracker?.sendUserInteractedTracking((controller?.getControllerName())!,
                                                recording: isRecording,
                                                interaction:AnalyticsConstants().CHANGE_FLASH,
                                                result: "true")
        }else{
            tracker?.sendUserInteractedTracking((controller?.getControllerName())!,
                                                recording: isRecording,
                                                interaction:AnalyticsConstants().CHANGE_FLASH,
                                                result: "false")
        }
    }
    
    func trackFrontCamera(){
        controller?.getTrackerObject().sendUserInteractedTracking((controller?.getControllerName())!,
                                                                  recording: isRecording,
                                                                  interaction:  AnalyticsConstants().CHANGE_CAMERA,
                                                                  result: AnalyticsConstants().CAMERA_FRONT)
    }
    
    func trackRearCamera(){
        controller?.getTrackerObject().sendUserInteractedTracking((controller?.getControllerName())!,
                                                                  recording: isRecording,
                                                                  interaction:  AnalyticsConstants().CHANGE_CAMERA,
                                                                  result: AnalyticsConstants().CAMERA_BACK)
    }
    
    func trackStartRecord(){
        controller?.getTrackerObject().mixpanel.timeEvent(AnalyticsConstants().VIDEO_RECORDED);
        
        controller?.getTrackerObject().sendUserInteractedTracking((controller?.getControllerName())!,
                                                                  recording: isRecording,
                                                                  interaction:  AnalyticsConstants().RECORD,
                                                                  result: AnalyticsConstants().START)
    }
    
    func trackExported(videoTotalTime:Double) {
        self.controller?.getTrackerObject().sendExportedVideoMetadataTracking(videoTotalTime,
                                                                              numberOfClips: Project.sharedInstance.numberOfClips())
    }
    
    func trackStopRecord(){
        controller?.getTrackerObject().sendUserInteractedTracking((controller?.getControllerName())!,
                                                                  recording: isRecording,
                                                                  interaction:  AnalyticsConstants().RECORD,
                                                                  result: AnalyticsConstants().STOP)
    }
    
    func trackSettingsPushed() {
        controller?.getTrackerObject().sendUserInteractedTracking((controller?.getControllerName())!,
                                                                  recording: isRecording,
                                                                  interaction:  AnalyticsConstants().INTERACTION_OPEN_SETTINGS,
                                                                  result: "")
    }
    
    func trackFilterSelected(name:String) {
        let filter = EffectProvider().getFilterByName(name)
        controller?.getTrackerObject().sendFilterSelectedTracking(filter.getType(),
                                                                  name: filter.getName().lowercaseString,
                                                                  code: filter.getIdentifier().lowercaseString,
                                                                  isRecording: isRecording,
                                                                  combined: isFiltersCombined(),
                                                                  filtersCombined: getFiltersActive())
    }
    
    //MARK: - FilterList delegate
    func hideAnyFilterList() {
        if(shaderFilterViewIsShowin || colorFilterViewIsShowin){
            self.recordWireframe?.dismissFilterListInterface({_ in })
            
            shaderFilterViewIsShowin = false
            colorFilterViewIsShowin = false
            
            controller?.showOverlayOnTop(shaderFilterViewIsShowin)
            controller?.showShadersOnTop(colorFilterViewIsShowin)
        }
    }
    
    func pushShowHideColorFilters() {
        if(shaderFilterViewIsShowin){
            shaderFilterViewIsShowin = false
            
            self.recordWireframe?.dismissFilterListInterface({
                finished in
              //Wait to hide filterlist
                if finished{
                    self.recordWireframe?.presentColorFilterListInterface()
                }
            })
            
            self.colorFilterViewIsShowin = true
            
            controller?.showOverlayOnTop(true)
            controller?.showShadersOnTop(false)
            
            return
        }else if(colorFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface({_ in})
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
            self.recordWireframe?.dismissFilterListInterface({
                finished in
                //Wait to hide filterlist
                if finished{
                    self.recordWireframe?.presentShaderFilterListInterface()

                }
            })
            
            self.shaderFilterViewIsShowin = true
            controller?.showOverlayOnTop(false)
            controller?.showShadersOnTop(true)
            return
        }else if(shaderFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface({_ in})
            
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
            
            self.setOverlayActive(filterName)
            self.trackFilterSelected(filterName)
        }else if ((filterDic[filterName]?.indexForKey(FilterType.SingleInput)) != nil){
            print("setFiltersOnView   SingleInputFilter")
            let newFilter = filterDic[filterName]?[FilterType.SingleInput]!
            cameraInteractor?.changeFilter(newFilter! as! GPUImageFilter)
            
            self.setShaderActive(filterName)
            self.trackFilterSelected(filterName)
        }else if (filterDic[filterName]?.indexForKey(FilterType.Shader)) != nil{
            print("setFiltersOnView   Shader")
            let newFilter = GPUImageFilter(fragmentShaderFromFile: filterName)
            cameraInteractor?.changeFilter(newFilter!)
            
            self.setShaderActive(filterName)
            self.trackFilterSelected(filterName)
        }else if (filterDic[filterName]?.indexForKey(FilterType.Other)) != nil{
            print("setFiltersOnView   Other")
            cameraInteractor?.removeFilters()
            self.SetShaderAndOverlayToInactive()
        }
    }
    
    func removeFilter(filterName: String) {
        let filterDic = effectDictionary
        
        if (filterDic[filterName]?.indexForKey(FilterType.Blend)) != nil{
            print("setFiltersOnView   blendFilter")
            cameraInteractor?.removeOverlay()
            
            setOverlayToInactive()
        }else if ((filterDic[filterName]?.indexForKey(FilterType.SingleInput)) != nil){
            print("setFiltersOnView   SingleInputFilter")
            cameraInteractor?.removeShaders()
            
            setShaderToInactive()
        }else if (filterDic[filterName]?.indexForKey(FilterType.Shader)) != nil{
            print("setFiltersOnView   Shader")
            cameraInteractor?.removeShaders()
            
            setShaderToInactive()
        }else if (filterDic[filterName]?.indexForKey(FilterType.Other)) != nil{
            print("setFiltersOnView   Other")
            cameraInteractor?.removeFilters()
            SetShaderAndOverlayToInactive()
        }
    }
    
    func resetRecorder() {
        controller?.hideRecordedVideoThumb()
        controller?.disableShareButton()
        
        cameraInteractor?.removeFilters()
        
        Project.sharedInstance.clear()
    }
    
    func changeOrientationEvent(){
        if(!isRecording){
            controller?.setOrientation()
        }
    }
    
    //MARK: - Camera delegate
    func trackVideoRecorded(videoLenght:Double) {
        controller?.getTrackerObject().trackTotalVideosRecordedSuperProperty()
        controller?.getTrackerObject().sendVideoRecordedTracking(videoLenght)
        controller?.getTrackerObject().updateTotalVideosRecorded()
    }
    
    func flashOn() {
        controller?.showFlashOn(true)
    }
    
    
    func flashOff() {
        controller?.showFlashOn(false)
    }
    
    func cameraRear() {
        controller?.showBackCameraSelected()
        self.trackRearCamera()
        controller?.showFlashSupported(true)
    }
    
    func cameraFront() {
        controller?.showFrontCameraSelected()
        self.trackFrontCamera()
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
    
    //MARK: - Set Overlay/Shader effects
    func setOverlayActive(filterName:String) {
        overlayActive = EffectOnView(effectName: filterName, effectActive: true)
    }
    
    func setShaderActive(filterName:String) {
        shaderActive = EffectOnView(effectName: filterName, effectActive: true)
    }
    
    func setOverlayToInactive() {
        overlayActive.effectActive = false
    }
    
    func setShaderToInactive() {
        shaderActive.effectActive = false
    }
    
    func SetShaderAndOverlayToInactive() {
        self.setShaderToInactive()
        self.setOverlayToInactive()
    }
    
    func isFiltersCombined() -> Bool {
        if overlayActive.effectActive && shaderActive.effectActive {
            return true
        }else{
            return false
        }
    }
    
    func getFiltersActive() -> [String] {
        var filters = [String]()
        if overlayActive.effectActive {
            filters.append(overlayActive.effectName)
        }
        if shaderActive.effectActive{
            filters.append(shaderActive.effectName)
        }
        
        return filters
    }
}