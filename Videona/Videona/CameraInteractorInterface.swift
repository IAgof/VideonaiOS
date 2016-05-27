//
//  CameraInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
protocol CameraInteractorDelegate {
    func flashOn()
    func flashOff()
    func cameraFront()
    func cameraRear()
}