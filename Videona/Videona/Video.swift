//
//  Video.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Video: Media {
    
    var isSplit:Bool!
    
    override init(title: String, mediaPath: String) {
        super.init(title: title, mediaPath: mediaPath)
        
        isSplit = false
    }
    
    func getIsSplit() -> Bool {
        return isSplit
    }
    
    func setIsSplit(state:Bool){
        self.isSplit = state
    }
}