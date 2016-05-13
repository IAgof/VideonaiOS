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
    
    var filters:Array<UIImage> = []
    
    func cancelFilterListAction() {
        wireframe?.dismissFilterListInterface(nil)
        filterListDelegate?.FilterListDidCancelAddAction()
    }
    func getColorFilterList() {
       filters = (interactor?.findColorFilters())!
        self.setFiltersToView()
    }
    
    func getShaderFilterList() {
        filters = (interactor?.findShaderFilters())!
        self.setFiltersToView()
   }
    
    func setFiltersToView(){
        controller?.setUpFiltersOnView(filters)
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: FilterListInterface) {
        
    }
}