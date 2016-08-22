//
//  IntroPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import PermissionScope

class IntroPresenter:NSObject, IntroPresenterInterface {
    
    //MARK: - VIPER
    var introWireframe: IntroWireframe?
    var controller: IntroViewInterface?
    var recordWireframe: RecordWireframe?
    
    //MARK: - Constants
    //Change to string file
    let nextTitle = Utils().getStringByKeyFromIntro(IntroTextConstants.NEXT)
    let doneTitle = Utils().getStringByKeyFromIntro(IntroTextConstants.FINISH)
    let skipTitle = Utils().getStringByKeyFromIntro(IntroTextConstants.SKIP)
    
    //MARK: - Interface
    func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(IntroPresenter.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)

        controller?.setUpView()
        controller?.changeNextFinishButtonTitle(nextTitle)
        controller?.changeSkipButtonTittle(skipTitle)
        controller?.setPermission()
        controller?.showPermission()

    }
    
    func checkOrientation(){
        controller?.updateConstaintsOnView()
    }
    
    func pushNext(buttonTitle:String) {
        print("Intro presenter onNextPush")
        
        if buttonTitle == nextTitle{
            controller?.goToNextView()
        }else{
            self.pushSkip()
        }
    }
    
    func onPageChange(numPage: Int, size: Int){
        if numPage == (size - 2) {
            controller?.changeNextFinishButtonTitle(nextTitle)
        }else if numPage == (size - 1) {//done
            controller?.changeNextFinishButtonTitle(doneTitle)
        }
        print("IntroPresenter on page change currentPage \(numPage)")
        controller?.updateCurrentPage(numPage)
    }
    
    func pushSkip(){
        print("Intro presenter onSkipPush")
        
        let canGoToRecordView = allPermissionsAutorized()
        
        if canGoToRecordView {
            recordWireframe?.setRecordViewControllerAsRootController()
        }else{
            controller?.showPermission()
        }
    }
    
    func allPermissionsAutorized() -> Bool {
        let permissionStatus = PermissionScope().permissionStatuses([PermissionType.Camera,PermissionType.Microphone,PermissionType.Photos])
        
        for permission in permissionStatus{
            if  (permission.1 == PermissionStatus.Unauthorized || permission.1 == PermissionStatus.Disabled || permission.1 == PermissionStatus.Unknown)  {
                return false
            }
        }
        
        return true
    }
    
}