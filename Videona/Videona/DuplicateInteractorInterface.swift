//
//  DuplicateInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol DuplicateInteractorInterface {
    func setUpComposition(videoSelectedIndex: Int,completion:(AVMutableComposition)->Void)
    func setVideoPosition(position:Int)
    func setDuplicateVideoToProject(numberDuplicates:Int)
    func getThumbnail(frame:CGRect)
}

protocol DuplicateInteractorDelegate {
    func setThumbnail(image:UIImage)
}