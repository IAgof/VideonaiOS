//
//  PlayerInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol PlayerInterface {
 
    func createVideoPlayer()
    func setPlayerMovieURL(movieURL:NSURL)
}