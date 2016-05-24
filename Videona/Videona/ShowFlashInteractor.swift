//
//  ShowFlashInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class SwitchFlashInteractor{
    
    let FLASH_ON = true
    let FLASH_OFF = false
    
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    func switchFlashState()->Bool{
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    
                    device.torchMode = AVCaptureTorchMode.Off
                    return FLASH_OFF
                } else {
                    
                    try device.setTorchModeOnWithLevel(1.0)
                    return FLASH_ON
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
                return FLASH_OFF
            }
        }else{
            return FLASH_OFF
        }
    }
}
