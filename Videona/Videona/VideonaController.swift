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

class VideonaController: UIViewController,
VideonaControllerInterface {

    let tracker = VideonaTracker()

    override func viewDidLoad() {
        print("View did load in \n \(self)")
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
