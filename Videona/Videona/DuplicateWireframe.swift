//
//  DuplicateWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import Foundation
import UIKit

let duplicateViewControllerIdentifier = "DuplicateViewController"

class DuplicateWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var duplicateViewController : DuplicateViewController?
    var duplicatePresenter : DuplicatePresenter?
    var playerWireframe: PlayerWireframe?
    
    var prevController:UIViewController?
    
    func presentDuplicateInterfaceFromWindow(window: UIWindow) {
        let viewController = duplicateViewControllerFromStoryboard()
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentDuplicateInterfaceFromViewController(prevController:UIViewController,
                                                videoSelected:Int)
    {
        let viewController = duplicateViewControllerFromStoryboard()
        
        self.prevController = prevController
        duplicatePresenter?.videoSelectedIndex = videoSelected
        prevController.showViewController(viewController, sender: nil)
    }
    
    func duplicateViewControllerFromStoryboard() -> DuplicateViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(duplicateViewControllerIdentifier) as! DuplicateViewController
        
        viewController.eventHandler = duplicatePresenter
        duplicateViewController = viewController
        duplicatePresenter?.delegate = viewController
        duplicatePresenter?.controller = viewController
        
        return viewController
    }
    
    func presentPlayerInterface() {
        playerWireframe?.presentPlayerInterfaceFromViewController(duplicateViewController!)
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func goPrevController(){
        duplicateViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}