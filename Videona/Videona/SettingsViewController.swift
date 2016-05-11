//
//  SettingsViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController,SettingsInterface , UINavigationBarDelegate{
    
    var output: SettingsPresenterInterface?
    var titleBar = "Share video"
    var titleBackButtonBar = "Back"
    
    override func viewDidLoad() {
        self.createNavigationBar()
    }
    
    func createNavigationBar(){
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = titleBar
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: titleBackButtonBar, style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(SettingsViewController.pushBackBarButton(_:)))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
    
    func pushBackBarButton(sender: UIBarButtonItem) {
        // Do something
        output?.pushBack()
    }
    
    func navigateToNewViewController(controller: UIViewController) {
        self.presentViewController(controller, animated: true, completion: nil)
    }
}