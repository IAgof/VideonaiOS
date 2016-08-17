//
//  FilterListPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import GPUImage

class FilterListPresenter:NSObject,FilterListPresenterInterface,FilterListInteractorDelegate{
    
    //MARK: - VIPER
    var interactor: FilterListInteractorInterface?
    var filterListDelegate: FilterListDelegate?
    
    var wireframe: FilterListWireframe?
    var controller: FilterListInterface?
    var recordWireframe: RecordWireframe?
    
    //MARK: - Variables
    var filtersImage:Array<UIImage> = []{
        didSet{
            if !filtersTitle.isEmpty  && !filtersImage.isEmpty{
                setFiltersToView()
            }
        }
    }
    var filtersTitle:Array<String> = []{
        didSet{
            if !filtersTitle.isEmpty  && !filtersImage.isEmpty{
                setFiltersToView()
            }
        }
    }
    
    var filterShowing = -1
    
    var lastShaderItemSelected:Int = -1
    var lastOverlayItemSelected:Int = -1
    
    //MARK: - Constants
    let FILTERS_SHOWING_IS_NONE = -1
    let FILTERS_SHOWING_IS_COLOR = 0
    let FILTERS_SHOWING_IS_SHADER = 1
    
    
    //MARK: - Get Filters list
    func getColorFilterList() {
        let index = NSIndexPath.init(forItem: lastOverlayItemSelected, inSection: 0)
        controller?.setSelectedCellIndexPath(index)
        
        interactor?.findColorFilters()
        
        self.setFilterShowin(FILTERS_SHOWING_IS_COLOR)
    }
    
    func getShaderFilterList() {
        let index = NSIndexPath.init(forItem: lastShaderItemSelected, inSection: 0)
        controller?.setSelectedCellIndexPath(index)
        
        interactor?.findShaderFilters()
        
        self.setFilterShowin(FILTERS_SHOWING_IS_SHADER)
    }
    
    //MARK: - Filters Actions
    func setFilterShowin(filterToShow:Int){
        self.filterShowing = filterToShow
    }
    
    func setFiltersToView(){
        controller?.setUpFiltersOnView(filtersImage,
                                       filtersTitle: filtersTitle)
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: FilterListInterface) {
        
    }
    
    func selectedFilter(filterItem: Int) {
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            interactor?.getShader(filterItem)
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            interactor?.getOverlay(filterItem)
        }
    }
    
    func removeFilter() {
        if filterShowing == FILTERS_SHOWING_IS_SHADER {
            filterListDelegate?.removeShader()
        }else if filterShowing == FILTERS_SHOWING_IS_COLOR{
            filterListDelegate?.removeOverlay()
        }
    }
    
    func removeBothFilters() {
        filterListDelegate?.removeOverlay()
        filterListDelegate?.removeShader()
    }
    
    func cancelFilterListAction() {
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            filterListDelegate!.pushShowHideShaderFilters()
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            filterListDelegate!.pushShowHideColorFilters()
        }
        
        self.removeBothFilters()
        
        lastShaderItemSelected = -1
        lastOverlayItemSelected = -1
        
        self.setFilterShowin(FILTERS_SHOWING_IS_NONE)
    }
    
    func toggleSelectedCell(cell: FilterViewCell,item: Int) {
        if (cell.isSelectedCell){
            cell.isSelectedCell = false
            self.removeFilter()
            self.handleIndexPathFiltersView(-1)
        }else{
            cell.isSelectedCell = true
            
            self.selectedFilter(item)
            
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
    
    func checkOtherCellSelected(indexPath: NSIndexPath,
                                lastSelectedIndexPath:NSIndexPath,
                                collectionView: UICollectionView) {
        
        if lastSelectedIndexPath != indexPath {
            if let cell = collectionView.cellForItemAtIndexPath(lastSelectedIndexPath) {
                let lastCell = cell as! FilterViewCell
                lastCell.isSelectedCell = false
            }
        }
    }
    
    //MARK: Interactor delegate
    func setFilterTitleList(list: [String]) {
        filtersTitle = list
    }
    
    func setFilterImageList(list: [UIImage]) {
        filtersImage = list
    }
    
    func setOverlayToView(filterName: String) {
        filterListDelegate?.setOverlay(filterName)
    }
    
    func setShaderToView(filter: GPUImageFilter
        , filterName: String) {
        filterListDelegate?.setShader(filter,
                                      filterName: filterName)
    }
}