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
,TimerInteractorDelegate,
ThumbnailDelegate{
    
    //MARK: - Variables VIPER
    var controller: RecordViewInterface?
    var cameraInteractor: CameraInteractorInterface?
    var timerInteractor: TimerInteractorInterface?
    
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    var thumbnailInteractor:ThumbnailInteractor?
    
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
            if self.isRecording{
                self.stopRecord()
            }
            FlashInteractor().turnOffWhenViewWillDissappear()
            dispatch_async(dispatch_get_main_queue(), {
                self.cameraInteractor?.stopCamera()
                self.controller?.showFlashOn(false)
            })
        })
    }
    
    func viewWillAppear() {
        cameraInteractor!.setResolution()
        cameraInteractor?.startCamera()
        
        controller?.forceOrientation()
        
        self.updateThumbnail()
    }
    
    
    func pushSettings() {
        print("Record presenter pushSettings")
        self.trackSettingsPushed()
        settingsWireframe?.presentSettingsInterfaceFromViewController((controller?.getController())!)
    }
    
    func pushShare() {
        recordWireframe?.presentShareInterfaceInsideEditorRoom()
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
            dispatch_async(dispatch_get_main_queue(), {
                self.cameraInteractor?.setIsRecording(true)
                
                self.cameraInteractor?.startRecordVideo({answer in
                    print("Record Presenter \(answer)")
                    Utils.sharedInstance.delay(1, closure: {
                        self.controller?.recordButtonEnable(true)
                    })
                })
                // update some UI
                self.controller?.showRecordButton()
                self.controller?.disableShareButton()
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
            
            self.updateThumbnail()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.controller?.showStopButton()
                self.controller?.enableShareButton()
            });
        });
        
        self.stopTimer()
    }
    
    func updateThumbnail() {
        let nClips = Project.sharedInstance.numberOfClips()
        
        if nClips > 0{
            let videoPath = Project.sharedInstance.getVideoList()[nClips - 1].getMediaPath()
            
           thumbnailInteractor = ThumbnailInteractor.init(videoPath: videoPath,
                                                 diameter: (self.controller?.getThumbnailSize())!)
            if thumbnailInteractor != nil {
                thumbnailInteractor?.delegate = self
                thumbnailInteractor?.getthumbnailImage()
            }
        }else{
            self.controller?.hideRecordedVideoThumb()
        }
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
        let nClips = Project.sharedInstance.numberOfClips()
        
        if nClips > 0{
            recordWireframe?.presentEditorRoomInterface()
        }else{
            recordWireframe?.presentGalleryInsideEditorRoomInterface()
        }
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
   
    func setOverlay(filterName:String) {
        cameraInteractor?.changeBlendImage(UIImage.init(named: filterName.lowercaseString)!)
        
        self.setOverlayActive(filterName)
        self.trackFilterSelected(filterName)
    }
    
    func setShader(filter:GPUImageFilter,
                   filterName:String) {
        cameraInteractor?.changeFilter(filter)
        
        self.setShaderActive(filterName)
        self.trackFilterSelected(filterName)
    }
    
    func removeShader() {
        cameraInteractor?.removeShaders()
        
        setShaderToInactive()
    }
    
    func removeOverlay() {
        cameraInteractor?.removeOverlay()
        
        setOverlayToInactive()
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
    
    func showFocus(center: CGPoint) {
        controller?.showFocusAtPoint(center)
    }
    
    //MARK: - Timer delegate
    func updateTimer(time: String) {
        controller?.updateChronometer(time)
    }
    //MARK: - Thumbnail delegate
    func setThumbToView(image: UIImage) {
        // update some UI
        dispatch_async(dispatch_get_main_queue(), {
            self.controller?.showRecordedVideoThumb(image)
            self.controller?.showNumberVideos(Project.sharedInstance.numberOfClips())
        });
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