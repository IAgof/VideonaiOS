//
//  FilterListPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import GPUImage

protocol FilterListPresenterInterface {
    
    func cancelFilterListAction()
    func getColorFilterList()
    func getShaderFilterList()
    func removeFilter()
    func toggleSelectedCell(cell:FilterViewCell,item: Int)
    func checkOtherCellSelected(indexPath: NSIndexPath,lastSelectedIndexPath:NSIndexPath, collectionView: UICollectionView)
}


protocol FilterListDelegate {
    func setShader(filter:GPUImageFilter,
                   filterName:String)
    func setOverlay(filterName:String)
    func removeShader()
    func removeOverlay()
    func pushShowHideColorFilters()
    func pushShowHideShaderFilters()
    func hideAnyFilterList()
}