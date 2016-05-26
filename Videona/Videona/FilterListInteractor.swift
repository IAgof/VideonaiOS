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
    
    func findColorFilters()-> (Array<UIImage>,Array<String>){
//        let colorFilters = EffectProvider().getColorEffectList()
        let colorFilters = EffectProvider().getOverlayFilterList()
        
        let socialNetworkImage = self.setArrayEffectUIImageAndTitle(colorFilters)
        
        return socialNetworkImage
    }
    
    func findShaderFilters()-> (Array<UIImage>,Array<String>){
        let shaderFilters = EffectProvider().getShaderEffectList()
        
        let socialNetworkImageAndImage = self.setArrayEffectUIImageAndTitle(shaderFilters)
        
        return socialNetworkImageAndImage
    }
    
    
    func setArrayEffectUIImageAndTitle(sNArray:Array<Effect>)->(Array<UIImage>,Array<String>){
        var imageArray = Array<UIImage>()
        var titleArray = Array<String>()
        
        for filter in sNArray{
            let image = UIImage.init(named: filter.getIconId())
            imageArray.append(image!)
            let title = filter.getName()
            titleArray.append(title)
        }
        
        return (imageArray,titleArray)
    }
    
}