//
//  FilterListWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let filterListViewIdentifier = "FilterListView"

class FilterListWireframe : NSObject{//, UIViewAnimationTransition {
    
    var filterListPresenter : FilterListPresenter?
    var presentedView : UIView?
    var rootWireframe : RootWireframe?

    func presentfilterListInterfaceFromViewController(newView: UIView, viewController:UIViewController) {
        let offsetX = CGFloat.init(-20)
        filterListPresenter?.configureUserInterfaceForPresentation(newView as! FilterListView)
        
        newView.center = CGPoint(x: ((viewController.view.bounds.size.width / 2) + offsetX), y: viewController.view.bounds.size.height )
        
        viewController.view.addSubview(newView)
        
        FilterListPresentationTransition().animateTransition(newView, completion: nil)
        
        presentedView = newView
    }
    
    func presentColorFilterListInterfaceFromViewController(viewController: UIViewController){
        let newView = filterListView()
        newView.eventHandler = filterListPresenter
        
        filterListPresenter?.controller = newView

        newView.getColorFiltersAsFilterList()
        newView.eventHandler = filterListPresenter
        newView.filtersCollectionView.registerNib(UINib.init(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: newView.reuseIdentifierCell)
        
        newView.initDelegates()
        
        self.presentfilterListInterfaceFromViewController(newView, viewController: viewController)
    }
    func presentShaderFilterListInterfaceFromViewController(viewController: UIViewController) {
        let newView = filterListView()
        newView.eventHandler = filterListPresenter
        
        filterListPresenter?.controller = newView

        newView.getShaderFiltersAsFilterList()
        newView.eventHandler = filterListPresenter
        newView.filtersCollectionView.registerNib(UINib.init(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: newView.reuseIdentifierCell)
        
        newView.initDelegates()
        
        self.presentfilterListInterfaceFromViewController(newView, viewController: viewController)
    }
    
    
    func dismissFilterListInterface(completion: ((Bool) -> Void)?) {
        FilterListDismissalTransition().animateTransition(presentedView!, completion: { finished in
            print("Filter list wireframe dismissFilterListInterface")
            self.presentedView?.removeFromSuperview()
        })
    }
    
    func filterListView() -> FilterListView {
        let filterListView: FilterListView = FilterListView.instanceFromNib() as! FilterListView
        return filterListView
    }
        
}