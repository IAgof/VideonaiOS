//
//  SplitInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol SplitInteractorInterface {
    func setVideoPosition(position:Int)
    func getVideoParams()
    func setUpComposition(completion:(AVMutableComposition)->Void)
    func setSplitVideosToProject(splitTime:Double)
}

protocol SplitInteractorDelegate {
    func settSplitValue(value:Float)
    func setMaximumValue(value:Float)
}