//
//  SplitViewInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol SplitViewInterface{
    func configureRangeSlider(splitValue: Float,
                              maximumValue:Float)
    func setSliderValue(value:Float)
    func bringToFrontExpandPlayerButton()
    func cameFromFullScreenPlayer(playerView:PlayerView)
}
