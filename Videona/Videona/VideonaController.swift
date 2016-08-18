//
//  VideonaController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import Mixpanel


let VIDEONA_GREEN_UICOLOR = UIColor.init(red: 0.7843, green: 0.8588, blue: 0.2039, alpha: 1.0)

class VideonaController: UIViewController,
VideonaControllerInterface {

    let tracker = VideonaTracker()
    
    override func viewDidLoad() {
        print("View did load in \n \(self)")
        self.prefersStatusBarHidden()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(VideonaController.hideStatusBarAlways),
                                                         name: UIDeviceOrientationDidChangeNotification,
                                                         object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will dissappear in \n \(self)")

        tracker.identifyMixpanel()

        tracker.startTimeInActivityEvent()

        tracker.sendControllerGAITracker(getControllerName())
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("View will dissappear in \n \(self)")

        tracker.sendTimeInActivity(getControllerName())
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func hideStatusBarAlways(){
        self.prefersStatusBarHidden()
    }

    func getControllerName()->String{
        return String(object_getClass(self))
    }
    
    func getTrackerObject() -> VideonaTracker {
        return self.tracker
    }
    
    func getController() -> UIViewController {
        return self
    }
}
