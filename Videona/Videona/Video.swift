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
    
    var VIDEO_PATH:String
    
    /**
     * The total duration of the file media resource
     */
    var fileDuration:Int
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, mediaPath:String,fileStartTime:Int,duration:Int,authors:Array<User>,license:License){
        super.init(identifier, iconPath, mediaPath, fileStartTime, duration, authors, license)
        fileDuration = duration
    }
    
    /**
     * Parametrized constructor. It requires all possible attributes for an effect object.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, selectedIconPath:String, title:String, mediaPath:String,fileStartTime:Int,duration:Int,opening:Transition,ending:Transition,metadata:NSMetadataItem,authors:Array<User>,license:License){
        super.init(identifier, iconPath, selectedIconPath, title, mediaPath, fileStartTime, duration,
        opening, ending, metadata, authors, license)
        self.fileDuration = duration
    }
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(mediaPath:String) {
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
    }
    
    init(mediaPath:String, fileStartTime:Int, duration:Int) {
        super.init(nil, nil, mediaPath, fileStartTime, duration, nil, nil)
        fileDuration = duration
    }
    
    init(video:Video) {
        super.init(nil, nil, video.getMediaPath(), video.getFileStartTime(),
        video.getDuration(), nil, nil)
        fileDuration = video.getFileDuration()
        fileStopTime = video.getFileStopTime()
    }
    
    func getFileDuration() ->Int{
        return fileDuration
    }
    
    func setFileDuration(fileDuration:Int) {
        self.fileDuration = fileDuration
    }
    
}
