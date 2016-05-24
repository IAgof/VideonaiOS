//
//  Project.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Project{
    /**
     * There could be just one project open at a time. So this converts Project in a Singleton.
     */
//    var INSTANCE:Project
    
    /**
     * Project name. Also it will be the name of the exported video
     */
    var title:String?
    /**
     * The folder where de temp files of the project are stored
     */
    var projectPath:String?
    /**
     * Track of Video an Image objects
     */
    var mediaTrack:MediaTrack
    /**
     * Audio tracks to form the final audio track. One by default, could be maximum defined on
     * project profile.
     */
    var audioTracks:Array<AudioTrack>
    
    /**
     * Project profile. Defines some limitations and characteristic of the project based on user
     * subscription.
     */
    var profile:Profile
    
    /**
     * Project duration. The duration of the project in milliseconds.
     */
    var duration:Double?
    
    var VIDEONA_PATH = ""
    
    /**
     * Constructor of minimum number of parameters. This is the Default constructor.
     *
     * @param title    - Project and final video name.
     * @param rootPath - Path to root folder for the current project.
     * @param profile  - Define some characteristics and limitations of the current project.
     */
    init(title:String,rootPath:String,profile:Profile) {
        self.title = title
        self.projectPath = rootPath + "/projects/" + title //todo probablemente necesitemos un slugify de ese title.
        self.mediaTrack = MediaTrack()
        self.audioTracks = Array<AudioTrack>()
        audioTracks.append(AudioTrack())
        self.profile = profile
        self.duration = 0.0
//        self.INSTANCE = Project()
        self.checkPathSetup(rootPath)
    }
    
    
    /**
     * @param rootPath
     */
    func checkPathSetup(rootPath:String) {
        
        //    Project.VIDEONA_PATH = rootPath
        //    File projectPath = new File(this.projectPath)
        //    projectPath.mkdirs()
        //
        //    Audio.AUDIO_PATH = rootPath + "/audios"
        //    File audioPath = new File(Audio.AUDIO_PATH + "/thumbs")
        //    audioPath.mkdirs()
        //
        //    Image.IMAGE_PATH = rootPath + "/images"
        //    File imagePath = new File(Image.IMAGE_PATH + "thumbs")
        //    imagePath.mkdirs()
        //
        //    Video.VIDEO_PATH = rootPath + "/videos"
        //    File videoPath = new File(Audio.AUDIO_PATH + "/thumbs")
        //    videoPath.mkdirs()
        
    }
    
    /**
     * Project factory.
     *
     * @return - Singleton instance of the current project.
     */
    
    // getters & setters
    func getTitle() ->String{
        return title!
    }
    
    func setTitle(title:String) {
        self.title = title
    }
    
    func getProjectPath()->String {
        return projectPath!
    }
    
    func setProjectPath(projectPath:String) {
        self.projectPath = projectPath
    }
    
    func getMediaTrack() ->MediaTrack{
        return mediaTrack
    }
    
    func setMediaTrack(mediaTrack:MediaTrack) {
        self.mediaTrack = mediaTrack
    }
    
    func getAudioTracks()->Array<AudioTrack> {
        return audioTracks
    }
    
    func setAudioTracks(audioTracks:Array<AudioTrack>) {
        self.audioTracks = audioTracks
    }
    
    func getProfile() ->Profile{
        return profile
    }
    
    func setProfile(profile:Profile) {
        self.profile = profile
    }
    
    func setDuration(duration:Double) {
        self.duration = duration
    }
    
    func getDuration() ->Double{
        duration = 0
        for video in mediaTrack.getItems() {
            duration = duration! + video.getDuration()
        }
        return duration!
    }
}

