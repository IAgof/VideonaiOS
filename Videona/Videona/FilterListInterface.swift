//
//  FilterListInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol FilterListInterface {
    
    func setUpFiltersOnView(filtersImage:Array<UIImage>,filtersTitle:Array<String>) 
    func setSelectedCellIndexPath(indexForItem:NSIndexPath)
}