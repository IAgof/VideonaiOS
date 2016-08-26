//
//  ReloadPositionVideosProjectUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 26/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class ReloadPositionVideosProjectUseCase: NSObject {
    
    static let sharedInstance = ReloadPositionVideosProjectUseCase()
    
    func reloadPositionNumberAfterMovement() {
        let videoList = Project.sharedInstance.getVideoList()
        
        if !videoList.isEmpty {
            for videoPosition in 1...(videoList.count) {
                videoList[videoPosition - 1].setPosition(videoPosition)
            }
            
            Project.sharedInstance.setVideoList(videoList)
        }
    }
}