//
//  Video.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Video: Media {
    
    private var isSplit:Bool!
    private var position:Int!
    
    override init(title: String, mediaPath: String) {
        super.init(title: title, mediaPath: mediaPath)
        
        isSplit = false
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = Video(title: title,
                         mediaPath: mediaPath)
        copy.setIsSplit(isSplit)
        copy.setPosition(position)
        copy.setStopTime(fileStopTime)
        copy.setStartTime(fileStartTime)
        copy.duration = duration
        
        return copy
    }
    
    func getIsSplit() -> Bool {
        return isSplit
    }
    
    func setIsSplit(state:Bool){
        self.isSplit = state
    }
    
    func getPosition()->Int{
        return self.position
    }
    
    func setPosition(position:Int){
        self.position = position
    }
    
//    func getThumbnailImage()->UIImageView{
//        return self.thumbnailImage
//    }
//    
//    func setThumbnailImage(imageView:UIImageView){
//        self.thumbnailImage = imageView
//    }
}