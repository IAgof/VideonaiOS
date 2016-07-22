//
//  EditingRoomWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 19/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

let EditingRoomViewControllerIdentifier = "EditingRoomViewController"

class EditingRoomWireframe : NSObject {
    //MARK: - Variables VIPER
    var rootWireframe : RootWireframe?
    var editingRoomViewController : EditingRoomViewController?
    var editingRoomPresenter : EditingRoomPresenter?
    
    //MARK: - Variables
    weak var currentViewController: UIViewController?
    var prevController:UIViewController?

    func presentEditingRoomInterfaceFromWindow(window: UIWindow) {
        let viewController = EditingRoomViewControllerFromStoryboard()
        
        viewController.eventHandler = editingRoomPresenter
        editingRoomViewController = viewController
        editingRoomPresenter?.controller = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func setEditingRoomViewControllerAsRootController() {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var homeViewController =  EditingRoomViewControllerFromStoryboard()
        let nav = UINavigationController(rootViewController: homeViewController)
        appdelegate.window!.rootViewController = nav
    }
    
    func presentEditingRoomInterfaceFromViewController(prevController:UIViewController) {
        let viewController = EditingRoomViewControllerFromStoryboard()

        self.prevController = prevController

        prevController.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func EditingRoomViewControllerFromStoryboard() -> EditingRoomViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(EditingRoomViewControllerIdentifier) as! EditingRoomViewController
        
        viewController.eventHandler = editingRoomPresenter
        editingRoomViewController = viewController
        editingRoomPresenter?.controller = viewController
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func goPrevController(){
        editingRoomViewController?.navigationController?.popToViewController(prevController!, animated: true)
    }
    
    func goBackToEditingRoomView(prevController:UIViewController){

        prevController.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func showEditorInContainer(){
        self.presentChildController("EditorViewController")
    }
    
    func showMusicInContainer(){
        self.presentChildController("Music")
    }
    
    func showShareInContainer(){
        self.presentChildController("ShareViewController")
    }
    
    func presentChildController(identifier:String){
        let newViewController = mainStoryboard().instantiateViewControllerWithIdentifier(identifier)
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
       
        if currentViewController == nil {
            self.currentViewController = mainStoryboard().instantiateViewControllerWithIdentifier(identifier)
            self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            editingRoomViewController!.addChildViewController(self.currentViewController!)
            self.addSubview(self.currentViewController!.view,
                            toView: editingRoomViewController!.containerView)
        }else{
            self.cycleFromViewController(self.currentViewController!,
                                         toViewController: newViewController)
            self.currentViewController = newViewController
        }
    }
    
    func cycleFromViewController(oldViewController: UIViewController,
                                 toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        editingRoomViewController!.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:editingRoomViewController!.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self.editingRoomViewController!)
        })
    }
    
    func addSubview(subView:UIView,
                    toView parentView:UIView) {
        
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
}