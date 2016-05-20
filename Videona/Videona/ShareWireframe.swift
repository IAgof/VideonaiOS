//
//  ShareWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let shareViewControllerIdentifier = "ShareViewController"

class ShareWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var shareViewController : ShareViewController?
    var sharePresenter : SharePresenter?
    var playerWireframe: PlayerWireframe?
    
    func presentShareInterfaceFromWindow(window: UIWindow) {
        let viewController = shareViewControllerFromStoryboard()
        viewController.eventHandler = sharePresenter
        
        shareViewController = viewController
        sharePresenter?.controller = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    func presentRecordInterfaceFromViewController(prevController:UIViewController) {
        let viewController = shareViewControllerFromStoryboard()
        
        viewController.eventHandler = sharePresenter
        shareViewController = viewController
        sharePresenter?.controller = viewController
        
        prevController.presentViewController(viewController, animated: true, completion: nil)
    }
    func shareViewControllerFromStoryboard() -> ShareViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(shareViewControllerIdentifier) as! ShareViewController
        
        viewController.eventHandler = sharePresenter
        shareViewController = viewController
        sharePresenter?.controller = viewController
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    func presentPlayerInterface() {
        playerWireframe?.presentPlayerInterfaceFromViewController(shareViewController!)
    }
}