//
//  FilterListInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


protocol FilterListInteractorInterface{
    func findColorFilters()
    func findShaderFilters()
}

protocol FilterListInteractorDelegate {
    func setFilterImageList(list:[UIImage])
    func setFilterTitleList(list:[String])
}