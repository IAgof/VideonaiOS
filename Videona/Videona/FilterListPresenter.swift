//
//  FilterListPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListPresenter:NSObject,FilterListPresenterInterface{
    
    var wireframe: FilterListWireframe?
    var controller: FilterListInterface?
    var interactor: FilterListInteractor?
    var filterListDelegate: FilterListDelegate?
    var recordWireframe: RecordWireframe?
    
    var filtersImage:Array<UIImage> = []
    var filtersTitle:Array<String> = []
    var filterShowing = -1
    
    let FILTERS_SHOWING_IS_NONE = 0
    let FILTERS_SHOWING_IS_COLOR = 0
    let FILTERS_SHOWING_IS_SHADER = 1
    
    func getColorFilterList() {
        filtersImage = (interactor?.findColorFilters().0)!
        filtersTitle = (interactor?.findColorFilters().1)!

        self.setFilterShowin(FILTERS_SHOWING_IS_COLOR)
        self.setFiltersToView()
    }
    
    func getShaderFilterList() {
        filtersImage = (interactor?.findShaderFilters().0)!
        filtersTitle = (interactor?.findShaderFilters().1)!
        
        self.setFilterShowin(FILTERS_SHOWING_IS_SHADER)
        self.setFiltersToView()
   }
    
    func setFilterShowin(filterToShow:Int){
        self.filterShowing = filterToShow
    }
    
    func setFiltersToView(){
        controller?.setUpFiltersOnView(filtersImage,filtersTitle: filtersTitle)
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: FilterListInterface) {
        
    }
    
    func filterListSelectedFilters(filter: String) {
        filterListDelegate?.setFiltersOnView(filter)
    }
    func removeShaderFilter(filterName:String) {
        filterListDelegate?.removeFilter(filterName)
    }
    func cancelFilterListAction() {
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            filterListDelegate!.pushShowHideShaderFilters()
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            filterListDelegate!.pushShowHideColorFilters()
        }
        self.setFilterShowin(FILTERS_SHOWING_IS_NONE)
    }
    func toggleSelectedCell(cell: FilterViewCell) {
        if (cell.isSelectedCell){
            cell.isSelectedCell = false
            cell.toggleSelected()
            self.removeShaderFilter(cell.filterTitle.text!)
        }else{
            cell.isSelectedCell = true
            cell.toggleSelected()
            let filter = cell.filterTitle.text
            self.filterListSelectedFilters(filter!)
        }
    }
    func checkOtherCellSelected(indexPath: NSIndexPath,lastSelectedIndexPath:NSIndexPath, collectionView: UICollectionView) {
        if lastSelectedIndexPath != indexPath {
            if let cell = collectionView.cellForItemAtIndexPath(lastSelectedIndexPath) {
                let lastCell = cell as! FilterViewCell
                lastCell.isSelectedCell = false
                lastCell.toggleSelected()
            }
        }else{
            if let cell = collectionView.cellForItemAtIndexPath(lastSelectedIndexPath) {
                let lastCell = cell as! FilterViewCell
                lastCell.isSelectedCell = true
                lastCell.toggleSelected()
            }
        }
    }
}