//
// Created by Alejandro Arjonilla Garcia on 15/6/16.
// Copyright (c) 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol AVQualityParseInterface {
    func resolutionsToView() -> Array<String>
    func parseResolutionsToInteractor(textResolution:String) -> String
}

class AVQualityParse: NSObject {
    var regularQuality = Utils().getStringByKeyFromSettings("low_quality_name")
    var mediumQuality =  Utils().getStringByKeyFromSettings("good_quality_name")
    var goodQuality =  Utils().getStringByKeyFromSettings("high_quality_name")

    func qualityToView() -> Array<String>  {
        var qualityToTheTableView = Array<String>()

        let qualityCompatibles = CompatibleQualityInteractor().getCompatibleQuality()

        for quality in qualityCompatibles {
            qualityToTheTableView.append(self.parseQualityToView(quality))
        }

        return qualityToTheTableView
    }

    func parseQualityToView(resolution:String) -> String {
        switch resolution {
        case AVCaptureSessionPresetHigh:
            return goodQuality
        case AVCaptureSessionPresetMedium:
            return mediumQuality
        case AVCaptureSessionPresetLow:
            return regularQuality
        default:
            return "Media (720)"
        }
    }

    func parseResolutionsToInteractor(textResolution:String) -> String {
        switch textResolution {
        case goodQuality:
            return AVCaptureSessionPresetHigh
        case mediumQuality:
            return AVCaptureSessionPresetMedium
        case regularQuality:
            return AVCaptureSessionPresetLow
        default:
            return AVCaptureSessionPresetMedium
        }
    }
}