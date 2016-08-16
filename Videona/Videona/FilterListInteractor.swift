//
//  FilterListInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListInteractor: NSObject,FilterListInteractorInterface {
    
    var delegate:FilterListInteractorDelegate?
    func findColorFilters(){
//        let colorFilters = EffectProvider().getColorEffectList()
        let colorFilters = EffectProvider().getOverlayFilterList()
        
        self.setArrayEffectUIImageAndTitle(colorFilters)
    }
    
    func findShaderFilters(){
        let shaderFilters = EffectProvider().getShaderEffectList()
        
        self.setArrayEffectUIImageAndTitle(shaderFilters)
    }
    
    func setArrayEffectUIImageAndTitle(sNArray:Array<Effect>){
        var imageArray = Array<UIImage>()
        var titleArray = Array<String>()
        
        for filter in sNArray{
            let image = UIImage.init(named: filter.getIconId())
            imageArray.append(image!)
            let title = filter.getName()
            titleArray.append(title)
        }
        
        delegate?.setFilterImageList(imageArray)
        delegate?.setFilterTitleList(titleArray)
    }
    
    
}