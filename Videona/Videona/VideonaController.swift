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

class VideonaController: UIViewController {
    let mixpanel = Mixpanel.sharedInstanceWithToken(AnalyticsConstants().MIXPANEL_TOKEN)

    
    override func viewDidLoad() {
        print("View did load in \n \(self)")
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will dissappear in \n \(self)")
        mixpanel.identify(Utils().udid)
        
        self.startTimeInActivityEvent()
        
        self.sendControllerGAITracker()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("View will dissappear in \n \(self)")
        self.sendTimeInActivity()
    }
    
    func startTimeInActivityEvent(){
        mixpanel.timeEvent(AnalyticsConstants().TIME_IN_ACTIVITY)
        Utils().debugLog("Sending startTimeInActivityEvent")
    }
    
    func sendControllerGAITracker(){
        Utils().debugLog("Send controller GoogleAnalytics Tracking")
        
        let tracker = GAI.sharedInstance().defaultTracker
        let controllerName = String(object_getClass(self))
        tracker.set(kGAIScreenName, value: controllerName)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func sendTimeInActivity() {
        Utils().debugLog("Sending AnalyticsConstants().TIME_IN_ACTIVITY")
        //NOT WORKING -- falta el comienzo time_event para arrancar el contador
        
        let controllerName = String(object_getClass(self))
        Utils().debugLog("what class is \(controllerName)")
        
        let viewProperties = [AnalyticsConstants().ACTIVITY:controllerName]
        mixpanel.track(AnalyticsConstants().TIME_IN_ACTIVITY, properties: viewProperties)
        mixpanel.flush()
    }
}
