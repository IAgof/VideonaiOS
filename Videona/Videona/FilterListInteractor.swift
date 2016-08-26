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
    
    var overlayFilters:[Effect]?
    var shaderFilters:[Effect]?
    
    func findColorFilters(){
        overlayFilters = EffectProvider().getOverlayFilterList()
        
        if let overlays = overlayFilters{
            self.setArrayEffectUIImageAndTitle(overlays)
        }
    }
    
    func findShaderFilters(){
        shaderFilters = EffectProvider().getShaderEffectList()
        
        if let shaders = shaderFilters{
            self.setArrayEffectUIImageAndTitle(shaders)
        }
    }
    
    func setArrayEffectUIImageAndTitle(list:Array<Effect>){
        var filterList = list
        
        var imageArray = Array<UIImage>()
        var titleArray = Array<String>()
        
        for count in 0...(filterList.count - 1){
            let filter = filterList[count]
            if let image = UIImage.init(named: filter.getIconId()){
                imageArray.append(image)
                let title = filter.getName()
                titleArray.append(title)
            }else{
                Utils.sharedInstance.debugLog("Item who cause problems\(filter.getName())")
            }
        }
        
        delegate?.setFilterImageList(imageArray)
        delegate?.setFilterTitleList(titleArray)
    }
    
    func getShader(item: Int) {
        if shaderFilters?.indices.contains(item) == true{
            let effect = shaderFilters![item] as! ShaderEffect
            
            delegate?.setShaderToView(effect.gpuImageEffect,
                                      filterName: effect.getName())
        }
    }
    
    func getOverlay(item: Int) {
        if overlayFilters?.indices.contains(item) == true{
            let effect = overlayFilters![item] as! OverlayEffect
            
            delegate?.setOverlayToView(effect.getResourceId())
        }
    }
}