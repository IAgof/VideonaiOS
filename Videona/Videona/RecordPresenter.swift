//
//  RecordPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class RecordPresenter: NSObject, RecordPresenterInterface,FilterListDelegate,CameraInteractorDelegate{
    
    //MARK: - Variables VIPER
    var controller: RecordController?
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    var cameraInteractor: CameraInteractor?
    
    //    var navigatorWireframe: NavigationWireframe?

    //MARK: - Constants
    var colorFilterViewIsShowin = false
    var shaderFilterViewIsShowin = false
    var isRecording = false

    //MARK: - Event handler
    func viewDidLoad(displayView:GPUImageView){
        
        controller?.configureView()
        cameraInteractor = CameraInteractor(display: displayView,cameraDelegate: self)
    }
    func pushSettings() {
        print("Record presenter pushSettings")
        settingsWireframe?.presentSettingsInterfaceFromViewController(controller!)
    }
    
    func pushShare() {
        print("Record presenter pushShare")
        shareWireframe?.presentRecordInterfaceFromViewController(controller!)
    }
    

    
    func pushFlash() {
        let flashState = FlashInteractor().switchFlashState()
        controller?.showFlashOn(flashState)
    }
    
    func pushRecord() {
        if isRecording {
            controller?.showStopButton()
            isRecording = false
        }else{
            controller?.showRecordButton()
            isRecording = true
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
    
    //MARK: - FilterList delegate
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
    
    //MARK: - Camera delegate
    func flashOn() {
        controller?.showFlashOn(true)
    }
    func flashOff() {
        controller?.showFlashOn(false)
    }
    func cameraRear() {
        controller?.showBackCameraSelected()
    }
    func cameraFront() {
        controller?.showFrontCameraSelected()
    }
}