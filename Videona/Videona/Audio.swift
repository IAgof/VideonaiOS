//
//  Audio.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * An audio media item that represents a file  (or part of a file) that can be used in project audio
 * track.
 *
 * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
 */
class Audio : Media {
    
    var AUDIO_PATH = ""
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, mediaPath:String,fileStartTime:Int,duration:Int,authors:Array<User>,license:License) {
        super.init(identifier, iconPath, mediaPath, fileStartTime, duration, authors, license);
    }
    
    /**
     * Parametrized constructor. It requires all possible attributes for an effect object.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, selectedIconPath:String, title:String, mediaPath:String,fileStartTime:Int,duration:Int,opening:Transition,ending:Transition,metadata:NSMetadataItem,authors:Array<User>,license:License){
        super.init(identifier, iconPath, selectedIconPath, title, mediaPath, fileStartTime, duration, opening, ending, metadata, authors, license);
    }
}