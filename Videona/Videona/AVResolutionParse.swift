//
//  AVResolutionParse.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

struct Resolution {
    var width:CGFloat
    var height:CGFloat
    
    var front:String = AVCaptureSessionPreset1280x720
    var back:String
    
    init(AVResolution:String){
        back = AVResolution
        
        switch AVResolution {
        case AVCaptureSessionPreset352x288:
            width = 352
            height = 288
            break
        case AVCaptureSessionPreset640x480:
            width = 640
            height = 480
            break
        case AVCaptureSessionPreset1280x720:
            width = 1280
            height = 720
            break
        case AVCaptureSessionPreset1920x1080:
            width = 1920
            height = 1080
            break
        default:
            width = 640
            height = 480
        }
    }
}
