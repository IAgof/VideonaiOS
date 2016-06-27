//
//  LoginWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let loginViewControllerIdentifier = "LoginViewController"

class LoginWireframe : NSObject {
    
    var rootWireframe : RootWireframe?
    var loginViewController : LoginInterface?
    var loginPresenter : LoginPresenterInterface?
    
    var prevController:UIViewController?
    
    func presentLoginInterfaceFromWindow(window: UIWindow) {
        let viewController = loginViewControllerFromStoryboard()
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentLoginInterfaceFromViewController(prevController:UIViewController) {
        let viewController = loginViewControllerFromStoryboard()
        
        self.prevController = prevController
        
        prevController.showViewController(viewController, sender: nil)
    }
    
    func loginViewControllerFromStoryboard() -> LoginController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(loginViewControllerIdentifier) as! LoginController
        
        viewController.setEventHandler(loginPresenter!)
        loginViewController = viewController
        loginPresenter?.setLoginInterface(viewController)
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func goPrevController(){
        loginViewController?.getSelfController().navigationController?.popToViewController(prevController!, animated: true)
    }
}