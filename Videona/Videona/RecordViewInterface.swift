//
//  RecordViewInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol RecordViewInterface {
    func showRecordButton()
    
    func showStopButton()
    
    func showSettings()
    
    func hideSettings()
    
    func showChronometer()
    
    func hideChronometer()
    
    func showRecordedVideoThumb(path:String)
    
    func hideRecordedVideoThumb()
    
    func showVideosRecordedNumber(numberOfVideos:Int)
    
    func hideVideosRecordedNumber()
    
    func startChronometer()
    
    func stopChronometer()
    
//    func showCameraEffectShader(List<Effect> effects)
//    
//    func showCameraEffectOverlay(List<Effect> effects)
    
    func lockScreenRotation()
    
    func unlockScreenRotation()
    
    func reStartScreenRotation()
    
    func showFlashOn(on:Bool)
    
    func showFlashSupported(state:Bool)
    
    func showFrontCameraSelected()
    
    func showBackCameraSelected()
    
    func showError(errorMessage:String) //videonaView
    
    func showErrorID(stringResourceId:Int) //videonaView
    
    func goToShare(videoToSharePath:String)
    
    func showProgressDialog()
    
    func hideProgressDialog()
    
    func showMessage(stringToast:Int)
    
    func enableShareButton()
    
    func disableShareButton()
    
    func finishActivityForResult(path:String)
}