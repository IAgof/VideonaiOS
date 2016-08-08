//
//  PlayerInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerInterface {
 
    func createVideoPlayer()
    func setPlayerMovieComposition(composition:AVMutableComposition)
    func updateLayers()
    func getView()->UIView
    func setUpVideoFinished()
    func pauseVideoPlayer()
    func playVideoPlayer()
    func updateSeekBarOnUI()
    func seekToTime(time: Float) 
}

protocol PlayerViewDelegate {
    func seekBarUpdate(value:Float)
}