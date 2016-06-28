//
//  FilterListInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


protocol FilterListInteractorInterface{
    func findColorFilters()-> (Array<UIImage>,Array<String>)
    func findShaderFilters()-> (Array<UIImage>,Array<String>)
}