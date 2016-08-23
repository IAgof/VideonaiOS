//
//  TrimInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 2/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol TrimInteractorInterface {
    func setParametersOnVideoSelectedOnProjectList(startTime:Float,
                                                   stopTime:Float)
    func setParametersOnVideoSelected(startTime:Float,
                                      stopTime:Float)
    func setUpComposition(completion:(AVMutableComposition)->Void)
    func setVideoPosition(position:Int)
    
    func getVideoParams()
}

protocol TrimInteractorDelegate {
    func setLowerValue(value:Float)
    func setUpperValue(value:Float)
    func setMaximumValue(value:Float)
    func updateParamsFinished()
}