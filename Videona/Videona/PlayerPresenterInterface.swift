//
//  PlayerPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerPresenterInterface {
    
    func createVideoPlayer(composition:AVMutableComposition)
    func layoutSubViews()
    func onVideoStops()
    func pauseVideo() 
    func videoPlayerViewTapped()
    func pushPlayButton()
    func updateSeekBar()
}


protocol PlayerDelegate {
    func PlayerDidCancelAddAction()
}