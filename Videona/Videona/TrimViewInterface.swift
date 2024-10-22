//
//  TrimViewInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol TrimViewInterface :VideonaControllerInterface{
    func configureRangeSlider(lowerValue: Float,
                              upperValue: Float,
                              maximumValue:Float)    
    func bringToFrontExpandPlayerButton()
    func cameFromFullScreenPlayer(playerView:PlayerView)
}