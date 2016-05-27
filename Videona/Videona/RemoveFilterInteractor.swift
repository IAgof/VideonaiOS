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
    func removeFilter(actualFilter:GPUImageFilter,imageView:UIImageView,display:GPUImageView){
        let image = UIImage.init(named: "filter_free")
        imageView.image = image
        
        actualFilter.removeAllTargets()
        actualFilter.addTarget(display)
    }
    
    func removeShader(actualFilter:GPUImageFilter,display:GPUImageView){
        actualFilter.removeAllTargets()
        actualFilter.addTarget(display)
    }
    func removeOverlay(imageView:UIImageView){
        let image = UIImage.init(named: "filter_free")
        imageView.image = image
    }
}