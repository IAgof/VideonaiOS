//
//  Video.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


/**
 * A media video item that represents a file (or part of a file) that can be used in project video
 * track.
 *
 * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
 */
class Video : Media {
    
    var VIDEO_PATH:String = ""
    
    /**
     * The total duration of the file media resource
     */
    var fileDuration:Double
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    override init(identifier:String,iconPath:String, mediaPath:String,fileStartTime:Double,duration:Double,authors:Array<User>,license:License){
        self.fileDuration = duration
        super.init(identifier: identifier, iconPath: iconPath, mediaPath: mediaPath, fileStartTime: fileStartTime, duration: duration, authors: authors, license: license)
    }
    
    /**
     * Parametrized constructor. It requires all possible attributes for an effect object.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    override init(identifier:String,iconPath:String, selectedIconPath:String, title:String, mediaPath:String,fileStartTime:Double,duration:Double,opening:Transition,ending:Transition,metadata:NSMetadataItem,authors:Array<User>,license:License){
        self.fileDuration = duration

        super.init(identifier: identifier, iconPath: iconPath, selectedIconPath: selectedIconPath, title: title, mediaPath: mediaPath, fileStartTime: fileStartTime, duration: duration,
                   opening: opening, ending: ending, metadata: metadata, authors: authors, license: license)
    }
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
//    init(mediaPath:String) {
//        super.init(nil, nil, mediaPath, 0, 0, nil, nil)
//        try {
//            MediaMetadataRetriever retriever = new MediaMetadataRetriever()
//            retriever.setDataSource(mediaPath)
//            duration = Integer.parseInt(retriever.extractMetadata(
//                MediaMetadataRetriever.METADATA_KEY_DURATION))
//            fileDuration = duration
//            fileStartTime = 0
//            fileStopTime = duration
//        } catch (Exception e) {
//            fileDuration = 0
//            duration = 0
//            fileStopTime = 0
//        }
//    }
    
//    init(mediaPath:String, fileStartTime:Double, duration:Double) {
//        super.init(identifier: nil, iconPath: nil, mediaPath: mediaPath, fileStartTime: fileStartTime, duration: duration, authors: nil, license: nil)
//        fileDuration = duration
//    }
    
//    init(video:Video) {
//        super.init(identifier: nil, iconPath: nil, mediaPath: video.getMediaPath(), fileStartTime: video.getFileStartTime(),
//                   duration: video.getDuration(), authors: nil, license: nil)
//        fileDuration = video.getFileDuration()
//        fileStopTime = video.getFileStopTime()
//    }
    
    func getFileDuration() ->Double{
        return fileDuration
    }
    
    func setFileDuration(fileDuration:Double) {
        self.fileDuration = fileDuration
    }
    
}
