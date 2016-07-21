//
//  Media.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 20/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class Media: NSObject {
    /**
     * Title of the media. Should be the video name in the social network
     */
    var title:String!
    
    /**
     * The path of the media resource
     */
    var mediaPath:String!
    
    // TODO(jliarte): 14/06/16 seems to not being used. If so, maybe initialize in getter?
    //    protected File source;
    
    /**
     * The start time of the media resource within the file it represents.
     */
    var fileStartTime:Double!
    
    /**
     * The stop time of the media resource within the file it represents.
     */
    var fileStopTime:Double!
    

    init(title:String,
                  mediaPath:String) {
        self.title = title
        self.mediaPath = mediaPath

        let urlAsset = NSURL(fileURLWithPath: mediaPath)
        let asset = AVAsset(URL: urlAsset)
        
        fileStartTime = 0.0
        fileStopTime = asset.duration.seconds
    }
    
    func getTitle() -> String {
        return title!
    }
    
    func setMediaTitle(title:String)  {
        self.title = title
    }
    
    func getMediaPath() -> String {
        return mediaPath!
    }
    
    func setVideonaMediaPath(path:String) {
        self.mediaPath = path
    }
    
    func getStartTime() -> Double {
        return fileStartTime
    }
    
    func setStartTime(time:Double) {
        self.fileStartTime = time
    }
    
    func getStopTime() -> Double {
        return fileStopTime
    }
    
    func setStopTime(time:Double) {
        self.fileStopTime = time
    }
    
    func getDuration() -> Double {
        return fileStopTime - fileStartTime
    }
}