//
//  RecordPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class RecordPresenter: NSObject, RecordPresenterInterface{
    
    //MARK: - Variables VIPER
    var output: RecordViewInterface?
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    
    //    var navigatorWireframe: NavigationWireframe?

    //MARK: - Constants
    var colorFilterViewIsShowin = false
    var shaderFilterViewIsShowin = false
    
    func pushSettings() {
        print("Record presenter pushSettings")
        let navigatorViewController = settingsWireframe?.settingsViewControllerFromStoryboard()
        
        output?.navigateToNewViewController(navigatorViewController!)
    }
    
    func pushShare() {
        print("Record presenter pushShare")
        let navigatorViewController = shareWireframe?.shareViewControllerFromStoryboard()
        
        output?.navigateToNewViewController(navigatorViewController!)
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
            return
        }else if(colorFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface()
            
            colorFilterViewIsShowin = false
            return
        }else{
            recordWireframe?.presentColorFilterListInterface()
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
            return
        }else if(shaderFilterViewIsShowin){
            recordWireframe?.dismissFilterListInterface()
            
            shaderFilterViewIsShowin = false
            return
        }else{
            recordWireframe?.presentShaderFilterListInterface()
            shaderFilterViewIsShowin = true
            return
        }
    }
    func showWarningOrientationImage(){
        output?.lockScreenRotation()
    }
    func hideWarningOrientationImage(){
        output?.unlockScreenRotation()
    }
}