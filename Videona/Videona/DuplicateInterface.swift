//
//  DuplicateInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol DuplicateInterface{

    func getThumbSize()->CGRect
    func showMinusButton()
    func hideMinusButton()
    func bringToFrontExpandPlayerButton()
    func cameFromFullScreenPlayer(playerView:PlayerView)
}