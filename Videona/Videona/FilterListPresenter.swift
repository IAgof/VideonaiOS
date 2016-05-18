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
    var recordPresenter:RecordPresenterInterface?
    
    var filters:Array<UIImage> = []
    var filterShowing = -1
    
    let FILTERS_SHOWING_IS_NONE = 0
    let FILTERS_SHOWING_IS_COLOR = 0
    let FILTERS_SHOWING_IS_SHADER = 1
    
    func cancelFilterListAction() {
        if(filterShowing == FILTERS_SHOWING_IS_SHADER){
            recordPresenter!.pushShowHideShaderFilters()
        }else if (filterShowing == FILTERS_SHOWING_IS_COLOR){
            recordPresenter!.pushShowHideColorFilters()
        }
        self.setFilterShowin(FILTERS_SHOWING_IS_NONE)
    }
    func getColorFilterList() {
        filters = (interactor?.findColorFilters())!
        self.setFilterShowin(FILTERS_SHOWING_IS_COLOR)
        self.setFiltersToView()
    }
    
    func getShaderFilterList() {
        filters = (interactor?.findShaderFilters())!
        self.setFilterShowin(FILTERS_SHOWING_IS_SHADER)
        self.setFiltersToView()
   }
    
    func setFilterShowin(filterToShow:Int){
        self.filterShowing = filterToShow
    }
    
    func setFiltersToView(){
        controller?.setUpFiltersOnView(filters)
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: FilterListInterface) {
        
    }
}