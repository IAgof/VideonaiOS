//
//  Project.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 20/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class Project: NSObject {
    
    /**
     * There could be just one project open at a time. So this converts Project in a Singleton.
     */
    static let sharedInstance = Project()

    //    private final String TAG = getClass().getCanonicalName()
    static var VIDEONA_PATH = ""
    
    /**
     * Project name. Also it will be the name of the exported video
     */
    private var title:String!
    /**
     * The folder where de temp files of the project are stored
     */
    private var projectPath:String!

    /**
     * Path where exported videos are
     */
    private var exportedPath:String!
    
    /**
     * List of Videos Recorded
     */
    private var videoList:Array<Video>!
    
    /**
     * Project profile. Defines some limitations and characteristic of the project based on user
     * subscription.
     */
    private  var profile:Profile!
    
    /**
     * Project duration. The duration of the project in milliseconds.
     */
    private var duration:Double = 0.0
    
    /**
     * Music to add to export video ( may be nil)
     */
    private var music: Audio?
    
    private override init() {
        self.title = "testTitle\(Utils().giveMeTimeNow())"
        self.projectPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        self.profile = Profile(resolution: "", videoQuality: "", maxDuration: 0, type: Profile.ProfileType.free)
        self.duration = 0
        
        videoList = Array<Video>()
    }
    
    // getters & setters
    func getTitle() ->String{
        return self.title!
    }
    
    func setTitle(title:String) {
        self.title = title
    }
    
    func getProjectPath() -> String{
        return projectPath!
    }
    
    func setProjectPath(projectPath:String) {
        self.projectPath = projectPath
    }
    
    func getProfile() -> Profile{
        return self.profile!
    }
    
    func setProfile(profile:Profile) {
        self.profile = profile
    }
    
    func getDuration()->Double {
        duration = 0
        for video in videoList{
            duration += video.getDuration()
        }
        return duration
    }
    
    func setDuration(duration:Double) {
        self.duration = duration
    }
    
    func clear() {
        self.title = "testTitle\(Utils().giveMeTimeNow())"
        self.projectPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        self.profile = Profile(resolution: "", videoQuality: "", maxDuration: 0, type: Profile.ProfileType.free)
        self.duration = 0
        
        videoList = Array<Video>()
    }
    
    func numberOfClips() -> Int{

        return videoList.count
    }
    
    func setVideoList(list:Array<Video>){
        self.videoList = list
    }
    
    func getVideoList() -> Array<Video> {
        return videoList
    }
    
    private func getNewProjectExportPath() -> String {
        return "\(projectPath)/videoExported\(Utils.sharedInstance.giveMeTimeNow()).m4v"
    }
    
    func setExportedPath() {
        self.exportedPath = self.getNewProjectExportPath()
    }
    
    func getExportedPath() -> String {
        return self.exportedPath
    }
//    func getMusic() ->Audio{
//        
//        return music
//    }
}