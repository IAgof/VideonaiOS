//
//  FilterListInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListInteractor: NSObject {
    
    func findColorFilters()-> Array<UIImage>{
        let colorFilters = EffectProvider().getColorEffectList()
        
        let socialNetworkImage = self.setArrayEffectUIImage(colorFilters)
        
        return socialNetworkImage
    }
    
    func findShaderFilters()-> Array<UIImage>{
        let colorFilters = EffectProvider().getShaderEffectList()
        
        let socialNetworkImage = self.setArrayEffectUIImage(colorFilters)
        
        return socialNetworkImage
    }
    
    
    func setArrayEffectUIImage(sNArray:Array<Effect>)->Array<UIImage>{
        var imageArray = Array<UIImage>()
        
        for filter in sNArray{
            let image = UIImage.init(named: filter.getIconId())
            imageArray.append(image!)
        }
        
        return imageArray
    }
    
}