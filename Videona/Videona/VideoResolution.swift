//
//  VideoResolution.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

class VideoResolution {
    
    var heigth:Int
    var width:Int
    
    
    enum Resolution {
        case HD720
        case HD1080
        case HD4K
    }
    
    init(resolution:Resolution) {
        switch (resolution) {
        case Resolution.HD1080:
            self.width = 1920
            self.heigth = 1080
            break
        case Resolution.HD4K:
            self.width = 3840
            self.heigth = 2160
            break
        case Resolution.HD720:
            self.width = 1280
            self.heigth = 720
            break
        default:
            self.width = 1280
            self.heigth = 720
        }
        
    }
    
    func getHeight() ->Int{
        return heigth
    }
    
    func getWidth()->Int {
        return width
    }
    
    
}
