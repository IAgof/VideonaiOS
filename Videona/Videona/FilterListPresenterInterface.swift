//
//  FilterListPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol FilterListPresenterInterface {
    
    func cancelFilterListAction()
    func getColorFilterList()
    func getShaderFilterList()
    func FilterListSelectedFilters(filter:Array<String>)
}


protocol FilterListDelegate {
    func setFiltersOnView(filters:Array<String>)
    func pushShowHideColorFilters()
    func pushShowHideShaderFilters()
}