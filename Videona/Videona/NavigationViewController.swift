//
//  NavigationViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import Foundation

class NavigationViewController: UIViewController,NavigationInterface {
    
    var output: NavigationPresenterInterface?
    
    //MARK: - Button Action
    @IBAction func pushCancel(sender: AnyObject) {
        output?.pushCancel()
    }
    
    @IBAction func pushRecord(sender: AnyObject) {
        output?.pushRecord()
    }
    @IBAction func pushEdit(sender: AnyObject) {
        output?.pushEdit()
    }
    @IBAction func pushShare(sender: AnyObject) {
        output?.pushShare()
    }
    
    @IBAction func pushGame(sender: AnyObject) {
        output?.pushGame()
    }
    
    @IBAction func pushSettings(sender: AnyObject) {
        output?.pushGame()
    }
    
    @IBAction func pushShutDown(sender: AnyObject) {
        output?.pushGame()
    }
    
    func navigateToNewViewController(controller: UIViewController) {
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
