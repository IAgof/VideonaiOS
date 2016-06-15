//
// Created by Alejandro Arjonilla Garcia on 15/6/16.
// Copyright (c) 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class CompatibleQualityInteractor: NSObject {

    func getCompatibleQuality() -> Array<String> {
        var compatibleQuality = Array<String>()

        compatibleQuality.append(AVCaptureSessionPresetHigh)
        compatibleQuality.append(AVCaptureSessionPresetMedium)
        compatibleQuality.append(AVCaptureSessionPresetLow)

        return compatibleQuality
    }
}