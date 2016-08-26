//
//  RemoveVideoFromProjectUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 26/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class RemoveVideoFromProjectUseCase: NSObject {
    
    static let sharedInstance = RemoveVideoFromProjectUseCase()
    
    func remove(index:Int){
        var videoList = Project.sharedInstance.getVideoList()
        
        videoList.removeAtIndex(index)
        
        Project.sharedInstance.setVideoList(videoList)
    }
}