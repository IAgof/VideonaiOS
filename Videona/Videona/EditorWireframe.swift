//
//  EditorWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

import Foundation
import UIKit

let editorViewControllerIdentifier = "EditorViewController"

class EditorWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var editorViewController : EditorViewController?
    var editorPresenter : EditorPresenter?
    
    var prevController:UIViewController?
    
    func presentEditorInterfaceFromWindow(window: UIWindow) {
        let viewController = editorViewControllerFromStoryboard()
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    func setEditorViewControllerAsRootController() {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let homeViewController =  editorViewControllerFromStoryboard()
        
        let nav = UINavigationController(rootViewController: homeViewController)
        appdelegate.window!.rootViewController = nav
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
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func goPrevController(){
        editorViewController?.navigationController?.popToViewController(prevController!, animated: true)
    }
    
    func goToAppleStoreURL(url:NSURL){
        if UIApplication.sharedApplication().canOpenURL(url){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func goToTwitterUserPage(user:String){
        let twitterURL = NSURL(string: "twitter://user?screen_name=\(user)")
        
        if UIApplication.sharedApplication().canOpenURL(twitterURL!){
            UIApplication.sharedApplication().openURL(twitterURL!)
        }else{
            let twitterBrowserURL = NSURL(string: "http://www.twitter.com/\(user)")
            UIApplication.sharedApplication().openURL(twitterBrowserURL!)
        }
    }
}