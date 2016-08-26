//
//  SplitWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

import Foundation
import UIKit

let splitViewControllerIdentifier = "SplitViewController"

class SplitWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var splitViewController : SplitViewController?
    var splitPresenter : SplitPresenter?
    var playerWireframe: PlayerWireframe?
    var fullScreenPlayerWireframe: FullScreenPlayerWireframe?

    var prevController:UIViewController?
    
    func presentSplitInterfaceFromWindow(window: UIWindow) {
        let viewController = splitViewControllerFromStoryboard()
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentSplitInterfaceFromViewController(prevController:UIViewController,
                                                     videoSelected:Int)
    {
        let viewController = splitViewControllerFromStoryboard()
        
        self.prevController = prevController
        splitPresenter?.videoSelectedIndex = videoSelected
        prevController.showViewController(viewController, sender: nil)
    }
    
    func splitViewControllerFromStoryboard() -> SplitViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(splitViewControllerIdentifier) as! SplitViewController
        
        viewController.eventHandler = splitPresenter
        splitViewController = viewController
        splitPresenter?.delegate = viewController
        splitPresenter?.controller = viewController
        
        return viewController
    }
    
    func presentPlayerInterface() {
        playerWireframe?.presentPlayerInterfaceFromViewController(splitViewController!)
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func goPrevController(){
        splitViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentExpandPlayer(){
        if let controller = splitViewController{
            if let player = playerWireframe?.presentedView{
                fullScreenPlayerWireframe?.presentFullScreenPlayerFromViewController(controller,
                                                                                     playerView:player)
            }
        }
    }
}