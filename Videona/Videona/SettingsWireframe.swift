//
//  SettingsWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let settingsViewControllerIdentifier = "SettingsViewController"

class SettingsWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var settingsViewController : SettingsViewController?
    var settingsPresenter : SettingsPresenter?
    
    func presentSettingsInterfaceFromWindow(window: UIWindow) {
        let viewController = settingsViewControllerFromStoryboard()
        viewController.eventHandler = settingsPresenter
        
        settingsViewController = viewController
        settingsPresenter?.controller = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentSettingsInterfaceFromViewController(prevController:UIViewController){
        let viewController = settingsViewControllerFromStoryboard()
        viewController.eventHandler = settingsPresenter
        
        settingsViewController = viewController
        settingsPresenter?.controller = viewController
        
        prevController.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func settingsViewControllerFromStoryboard() -> SettingsViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(settingsViewControllerIdentifier) as! SettingsViewController
        
        viewController.eventHandler = settingsPresenter
        settingsViewController = viewController
        settingsPresenter?.controller = viewController
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
}