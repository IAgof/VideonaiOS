//
//  EffectDictionary.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 25/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

enum FilterType {
    case SingleInput
    case Blend
    case Shader
    case Other
}

var effectDictionary:[String:[FilterType:AnyObject]] =
    ["Sepia": [.SingleInput:GPUImageSepiaFilter.init()],
     "Night": [.SingleInput:NightFilter.init().nightFilter!],
     "Emboss": [.SingleInput:GPUImageEmbossFilter.init()],
//     "Posterizebw": [.SingleInput:PosterizebwFilter.init().posterizebwFilter!],
//     "Posterize": [.SingleInput:GPUImagePosterizeFilter.init()],
     "Aqua": [.SingleInput:BlueFilter.init().blueFilter!],
     "Negative": [.SingleInput:GPUImageColorInvertFilter.init()],
     "Mono": [.SingleInput:GPUImageGrayscaleFilter.init()],
     
     "Dirty": [.Blend:GPUImageGrayscaleFilter.init()],
     "Retrogame": [.Blend:GPUImageGrayscaleFilter.init()],
     "Game": [.Blend:GPUImageGrayscaleFilter.init()],
     "Tattoo": [.Blend:GPUImageGrayscaleFilter.init()],
     "Unicorn": [.Blend:GPUImageGrayscaleFilter.init()],
     "Hawai": [.Blend:GPUImageGrayscaleFilter.init()],
     "Baby": [.Blend:GPUImageGrayscaleFilter.init()],
     "NY": [.Blend:GPUImageGrayscaleFilter.init()],
     "Holidays": [.Blend:GPUImageGrayscaleFilter.init()],
     "Olimpic": [.Blend:GPUImageGrayscaleFilter.init()],
     "Overlay": [.Blend:GPUImageGrayscaleFilter.init()],

     "Mirror": [.Shader:GPUImageFilter()],
     "Dent": [.Shader:GPUImageFilter()],
     "Squeeze": [.Shader:GPUImageFilter()],
     "Posterize": [.Shader:GPUImageFilter()],
     "Posterizebw": [.Shader:GPUImageFilter()],
     "Stretch": [.Shader:GPUImageFilter()],
     "Fisheye": [.Shader:GPUImageFilter()],
     "Twirl": [.Shader:GPUImageFilter()],
     "Tunnel": [.Shader:GPUImageFilter()],
     "Bulge": [.Shader:GPUImageFilter()],
     "Shader": [.Shader:GPUImageFilter()],
]


class BlueFilter:NSObject{
    var blueFilter:GPUImageMonochromeFilter?
    
    override init(){
        blueFilter = GPUImageMonochromeFilter()
        blueFilter!.setColorRed(0.44, green: 0.55, blue: 0.89)
    }
}

class PosterizebwFilter:NSObject{
    var posterizebwFilter:GPUImageFilter?
    
    override init(){
        let filterMask = GPUImageFilter()
        let filterGroup = GPUImageFilterGroup()
        
        let posterizeFilter = GPUImagePosterizeFilter()
        let mono = GPUImageGrayscaleFilter()
        
        filterGroup.addFilter(posterizeFilter)
        filterGroup.addFilter(mono)

        posterizeFilter.addTarget(mono)
        
        filterGroup.initialFilters = NSArray.init(object: posterizeFilter) as [AnyObject]
        filterGroup.terminalFilter = mono
        
        filterMask.addTarget(filterGroup)
        
        posterizebwFilter = filterMask
    }
}

class NightFilter:NSObject{
    var nightFilter:GPUImageMonochromeFilter?
    
    override init(){
        nightFilter = GPUImageMonochromeFilter()
        nightFilter!.setColorRed(0.0, green: 0.55, blue: 0.0)
    }
}

class BlendFilter:NSObject{
    var output:GPUImageFilter?
    
    override init() {
        
    }
}
