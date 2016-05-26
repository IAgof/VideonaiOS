//
//  ChangeFilterInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 25/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

class ChangeFilterInteractor{
    func changeFilter(actualFilter:GPUImageFilter, newFilter:GPUImageFilter,display:GPUImageView){
        newFilter.removeAllTargets()
        actualFilter.removeAllTargets()
        actualFilter.addTarget(newFilter)
        
        newFilter.addTarget(display)
    }
}