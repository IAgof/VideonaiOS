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
        
        videoList.append(video)
        
        Project.sharedInstance.setVideoList(videoList)
    }
}