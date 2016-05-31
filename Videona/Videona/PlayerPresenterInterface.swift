//
//  PlayerPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol PlayerPresenterInterface {
    
    func createVideoPlayer(videoPath:String)
    func layoutSubViews()
}


protocol PlayerDelegate {
    func PlayerDidCancelAddAction()
}