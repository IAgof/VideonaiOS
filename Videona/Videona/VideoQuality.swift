//
//  VideoQuality.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class VideoQuality {
    
    var videoBitRate:Int
    
    enum Quality {
        case GOOD
        case VERY_GOOD
        case EXCELLENT
    }
    
    init(quality:Quality) {
        switch (quality) {
        case Quality.GOOD:
            self.videoBitRate = 2000000
            break
        case Quality.EXCELLENT:
            self.videoBitRate = 10000000
            break
        case Quality.VERY_GOOD:
            self.videoBitRate = 5000000
            break
        default:
            self.videoBitRate = 5000000
        }
    }
    
    func getVideoBitRate() ->Int{
        return videoBitRate
    }
}