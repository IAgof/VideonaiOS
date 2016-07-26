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
            for videoPosition in 0...(videoList.count - 1) {
                videoList[videoPosition].setPosition(videoPosition + 1)
            }
            
            Project.sharedInstance.setVideoList(videoList)
        }
    }
}