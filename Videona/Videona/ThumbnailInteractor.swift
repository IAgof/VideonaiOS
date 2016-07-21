//
//  ThumbnailInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 30/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ThumbnailInteractor: NSObject {
    var thumbnailImageView: UIImageView!
    var videoPath:String!
    var diameter:CGFloat = 40.0

    init(videoPath:String,diameter:CGFloat) {
        self.videoPath = videoPath
        self.thumbnailImageView = UIImageView.init(frame: CGRectMake(0, 0, diameter, diameter))
        self.diameter = diameter
    }
    
    func getThumbnailImageView()->UIImageView{
        let asset = AVURLAsset(URL: NSURL(fileURLWithPath: videoPath), options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        var cgImage:CGImage?
        do {
            cgImage =  try imgGenerator.copyCGImageAtTime(kCMTimeZero, actualTime: nil)
            print("Thumbnail image gets okay")
            
            // !! check the error before proceeding
            var thumbnail = UIImage(CGImage: cgImage!)
            thumbnail = self.resizeImage(thumbnail, newWidth: diameter)
            // lay out this image view, or if it already exists, set its image property to uiImage
            
            thumbnailImageView.image = thumbnail
        } catch {
            print("Thumbnail error \nSomething went wrong!")
        }

        self.setCornerToThumbnail()
        self.setBorderToThumb()
        
        return thumbnailImageView
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        print("Resize image")
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newWidth))
        image.drawInRect(CGRectMake(0, 0, newWidth, newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print("Finish resize image")
        return newImage
    }
    
    func setCornerToThumbnail(){
        diameter = diameter/2
        
        thumbnailImageView.layer.cornerRadius = diameter
        thumbnailImageView.clipsToBounds = true
    }
    
    func setBorderToThumb(){
        let borderLayer = self.getBorderLayer()
        thumbnailImageView.layer.addSublayer(borderLayer)
    }
    
    func getBorderLayer() -> CALayer{
        let borderLayer = CALayer.init()
        let borderFrame = CGRectMake(0,0,thumbnailImageView.frame.size.width, thumbnailImageView.frame.size.height)
        
        //Set properties border layer
        borderLayer.backgroundColor = UIColor.clearColor().CGColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = diameter
        borderLayer.borderWidth = 3
        borderLayer.borderColor = UIColor.whiteColor().CGColor
        
        return borderLayer
    }

}