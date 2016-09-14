//
//  FilterListInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

protocol FilterListInteractorInterface{
    func findColorFilters()
    func findShaderFilters()
    func getShader(item:Int)
    func getOverlay(item:Int)
    
}

protocol FilterListInteractorDelegate {
    func setFilterImageList(list:[UIImage])
    func setFilterTitleList(list:[String])
    func setShaderToView(filter:GPUImageFilter,
                         filterName:String)
    func setOverlayToView(filterName:String)
    func forceToSetShader(item:Int)
}