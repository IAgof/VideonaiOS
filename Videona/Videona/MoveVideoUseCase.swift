//
//  MoveVideoUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 26/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class MoveVideoUseCase: NSObject {
    static let sharedInstance = MoveVideoUseCase()
    
    func moveClipToPosition(sourcePosition:Int,
                            destionationPosition:Int){
        var videoList = Project.sharedInstance.getVideoList()
        
        let videoToMove = videoList[sourcePosition]
        videoList.removeAtIndex(sourcePosition)
        videoList.insert(videoToMove, atIndex: destionationPosition)

        Project.sharedInstance.setVideoList(videoList)
    }
    
}