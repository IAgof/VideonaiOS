//
//  AddVideoToProjectUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class AddVideoToProjectUseCase: NSObject {
    
    static let sharedInstance = AddVideoToProjectUseCase()
    
    func add(videoPath:String,
             title:String){
        var videoList = Project.sharedInstance.getVideoList()
        
        let video = Video.init(title: title,
                               mediaPath: videoPath)
        video.setPosition(videoList.count + 1)
        
        videoList.append(video)
        
        Project.sharedInstance.setVideoList(videoList)
    }
    
    func add(video:Video,
             position:Int){
        
        var videoList = Project.sharedInstance.getVideoList()
        
        videoList.insert(video, atIndex: position)
        
        Project.sharedInstance.setVideoList(videoList)
    }
    
    func updateVideoParams() {
        let videoList = Project.sharedInstance.getVideoList()
        videoList.last?.mediaRecordedFinished()
    }
}