//
//  EditorWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//
import Foundation
import UIKit

let editorViewControllerIdentifier = "EditorViewController"

class EditorWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var editorViewController : EditorViewController?
    var editorPresenter : EditorPresenter?
    var playerWireframe: PlayerWireframe?
    var fullScreenPlayerWireframe: FullScreenPlayerWireframe?

    var prevController:UIViewController?
    
    func presentEditorInterfaceFromWindow(window: UIWindow) {
        let viewController = editorViewControllerFromStoryboard()
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentEditorInterfaceFromViewController(prevController:UIViewController){
        let viewController = editorViewControllerFromStoryboard()
        
        self.prevController = prevController
        
        prevController.showViewController(viewController, sender: nil)
    }
    
    func editorViewControllerFromStoryboard() -> EditorViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(editorViewControllerIdentifier) as! EditorViewController
        
        viewController.eventHandler = editorPresenter
        editorViewController = viewController
        editorPresenter?.controller = viewController
        
        return viewController
    }
    
    func presentPlayerInterface() {
        playerWireframe?.presentPlayerInterfaceFromViewController(editorViewController!)
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
}