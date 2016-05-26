//
//  RemoveFilterInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 25/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class RemoveFilterInteractor:NSObject{
    func removeFilter(actualFilter:GPUImageFilter, videoCamera:GPUImageVideoCamera,display:GPUImageView){
        videoCamera.removeAllTargets()

        videoCamera.addTarget(actualFilter)
        actualFilter.addTarget(display)
    }
}