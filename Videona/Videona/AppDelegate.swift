//
//  AppDelegate.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDependencies = AppDependencies()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupStartApp()
        
        return true
    }
    
    func setupStartApp() {//Check version and initial state of the app to show new features or initial message
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let currentAppVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        let previousVersion = defaults.stringForKey("appVersion")
        if previousVersion == nil {
            // first launch
            defaults.setObject(currentAppVersion, forKey: "appVersion")
            defaults.synchronize()
            
            appDependencies.installIntroToRootViewControllerIntoWindow(window!)
        } else if previousVersion == currentAppVersion {
            // same version

            //Change to test the IntroView
            appDependencies.installRecordToRootViewControllerIntoWindow(window!)
//                        appDependencies.installIntroToRootViewControllerIntoWindow(window!)
        } else {
            // other version
            defaults.setObject(currentAppVersion, forKey: "appVersion")
            defaults.synchronize()
            
            appDependencies.installRecordToRootViewControllerIntoWindow(window!)
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        Utils().debugLog("\nEnter in applicationWillResignActive\n")
        if let viewControllers = self.window?.rootViewController?.childViewControllers {
            for viewController in viewControllers {
                if viewController.isKindOfClass(RecordController) {
                    let myViewController = viewController as! RecordController
                    myViewController.eventHandler?.viewWillDisappear()
                    Utils().debugLog("Found the view controller")
                }
            }
        }
    }
}

