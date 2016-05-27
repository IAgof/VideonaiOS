//
//  FilterListPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol FilterListPresenterInterface {
    
    func cancelFilterListAction()
    func getColorFilterList()
    func getShaderFilterList()
    func filterListSelectedFilters(filter:String)
    func removeFilter(filterName:String)
    func toggleSelectedCell(cell:FilterViewCell)
    func checkOtherCellSelected(indexPath: NSIndexPath,lastSelectedIndexPath:NSIndexPath, collectionView: UICollectionView) 
}


protocol FilterListDelegate {
    func setFiltersOnView(filterName:String)
    func removeFilter(filterName: String) 
    func pushShowHideColorFilters()
    func pushShowHideShaderFilters()
}