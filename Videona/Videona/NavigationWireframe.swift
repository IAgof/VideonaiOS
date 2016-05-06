//
//  NavigationWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let NavigationViewControllerIdentifier = "NavigationViewController"

class NavigationWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var navigationViewController : NavigationViewController?
    var navigationPresenter : NavigationPresenter?
    
    func presentNavigatorInterfaceFromWindow(window: UIWindow) {
        let viewController = NavigationViewControllerFromStoryboard()
        viewController.output = navigationPresenter
        
        navigationViewController = viewController
        navigationPresenter?.controller = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func NavigationViewControllerFromStoryboard() -> NavigationViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(NavigationViewControllerIdentifier) as! NavigationViewController
       
        viewController.output = navigationPresenter
        navigationViewController = viewController
        navigationPresenter?.controller = viewController
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
}