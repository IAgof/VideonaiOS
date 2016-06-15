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
        case AVAssetExportPresetHighestQuality:
            return goodQuality
        case AVAssetExportPresetMediumQuality:
            return mediumQuality
        case AVAssetExportPresetLowQuality:
            return regularQuality
        default:
            return "Media (720)"
        }
    }

    func parseResolutionsToInteractor(textResolution:String) -> String {
        switch textResolution {
        case goodQuality:
            return AVAssetExportPresetHighestQuality
        case mediumQuality:
            return AVAssetExportPresetMediumQuality
        case regularQuality:
            return AVAssetExportPresetLowQuality
        default:
            return AVAssetExportPresetMediumQuality
        }
    }
}