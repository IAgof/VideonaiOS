//
//  IntroWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let IntroViewControllerIdentifier = "IntroViewController"

class IntroWireframe:NSObject {
    var rootWireframe: RootWireframe?
    var introViewController: IntroViewController?
    var introPresenter: IntroPresenter?
    
    func presentIntroInterfaceFromWindow(window: UIWindow){
        let viewController = IntroViewControllerFromStoryboard()
        viewController.eventHandler = introPresenter
        
        introViewController = viewController
        introPresenter?.controller = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
 
    func IntroViewControllerFromStoryboard() -> IntroViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(IntroViewControllerIdentifier) as! IntroViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
}