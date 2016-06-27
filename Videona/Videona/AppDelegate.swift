//
//  AppDelegate.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    let appDependencies = AppDependencies()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupStartApp()
        
        self.configureGoogleSignIn()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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
            
            //Record controller on start
//            appDependencies.installRecordToRootViewControllerIntoWindow(window!)
            //Intro controller on start
//                appDependencies.installIntroToRootViewControllerIntoWindow(window!)
            //Login controller on start
            appDependencies.installLoginToRootViewControllerIntoWindow(window!)
        } else {
            // other version
            defaults.setObject(currentAppVersion, forKey: "appVersion")
            defaults.synchronize()
            
            appDependencies.installRecordToRootViewControllerIntoWindow(window!)
        }
    }
    
    func configureGoogleSignIn() {
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
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
    
    //MARK: - Google Sign In
    func application(application: UIApplication,
                     openURL url: NSURL,
                             options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func application(application: UIApplication,
                            openURL url: NSURL,
                             sourceApplication: String?,
                             annotation: AnyObject) -> Bool {
        
        print("sourceApp\(sourceApplication)")
        
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            Utils().debugLog("userID: \(userId) \n idToken: \(idToken) \n fullName: \(fullName) \n givenName: \(givenName) \n familyName: \(familyName) \n email: \(email) \n")
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
}

