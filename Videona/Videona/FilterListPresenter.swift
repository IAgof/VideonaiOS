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
    
    //MARK: - VIPER
    var wireframe: FilterListWireframe?
    var controller: FilterListInterface?
    var interactor: FilterListInteractor?
    var filterListDelegate: FilterListDelegate?
    var recordWireframe: RecordWireframe?
    
    //MARK: - Variables
    var filtersImage:Array<UIImage> = []
    var filtersTitle:Array<String> = []
    var filterShowing = -1
    
    
    var lastShaderItemSelected:Int = -1
    var lastOverlayItemSelected:Int = -1
    
    //MARK: - Constants
    let FILTERS_SHOWING_IS_NONE = -1
    let FILTERS_SHOWING_IS_COLOR = 0
    let FILTERS_SHOWING_IS_SHADER = 1


    //MARK: - Get Filters list
    func getColorFilterList() {
        controller?.setSelectedCellIndexPath(lastOverlayItemSelected)
        
        filtersImage = (interactor?.findColorFilters().0)!
        filtersTitle = (interactor?.findColorFilters().1)!

        self.setFilterShowin(FILTERS_SHOWING_IS_COLOR)
        self.setFiltersToView()
        
    }
    
    func getShaderFilterList() {
        controller?.setSelectedCellIndexPath(lastShaderItemSelected)
        
        filtersImage = (interactor?.findShaderFilters().0)!
        filtersTitle = (interactor?.findShaderFilters().1)!
        
        self.setFilterShowin(FILTERS_SHOWING_IS_SHADER)
        self.setFiltersToView()
        
 
    }
    
    //MARK: - Filters Actions
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
    func removeFilter(filterName:String) {
        filterListDelegate?.removeFilter(filterName)
    }
    
    func cancelFilterListAction() {
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            filterListDelegate!.pushShowHideShaderFilters()
            self.removeFilter("Shader")
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            filterListDelegate!.pushShowHideColorFilters()
            self.removeFilter("Overlay")
        }
        self.setFilterShowin(FILTERS_SHOWING_IS_NONE)
    }
    
    func toggleSelectedCell(cell: FilterViewCell,item: Int) {
        if (cell.isSelectedCell){
            cell.isSelectedCell = false
            self.removeFilter(cell.filterTitle.text!)
            self.handleIndexPathFiltersView(-1)
        }else{
            cell.isSelectedCell = true
            let filter = cell.filterTitle.text
            self.filterListSelectedFilters(filter!)
            self.handleIndexPathFiltersView(item)
        }
    }
    
    func handleIndexPathFiltersView(item:Int){
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            lastShaderItemSelected = item
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            lastOverlayItemSelected = item
        }

    }
    
    func checkOtherCellSelected(indexPath: NSIndexPath,lastSelectedIndexPath:NSIndexPath, collectionView: UICollectionView) {
        
        if lastSelectedIndexPath != indexPath {
            if let cell = collectionView.cellForItemAtIndexPath(lastSelectedIndexPath) {
                let lastCell = cell as! FilterViewCell
                lastCell.isSelectedCell = false
            }
        }
    }
}