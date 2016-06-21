//
// Created by Alejandro Arjonilla Garcia on 21/6/16.
// Copyright (c) 2016 Videona. All rights reserved.
//

import Foundation
import Mixpanel

class VideonaTracker {
    let mixpanel = Mixpanel.sharedInstanceWithToken(AnalyticsConstants().MIXPANEL_TOKEN)

    //MARK: - Identify Mixpanel
    func identifyMixpanel(){
        mixpanel.identify(Utils().udid)
    }

    //MARK: - Time in activity track
    func startTimeInActivityEvent(){
        mixpanel.timeEvent(AnalyticsConstants().TIME_IN_ACTIVITY)
        Utils().debugLog("Sending startTimeInActivityEvent")
    }

    func sendTimeInActivity(controllerName:String) {
        Utils().debugLog("Sending AnalyticsConstants().TIME_IN_ACTIVITY")
        //NOT WORKING -- falta el comienzo time_event para arrancar el contador

        Utils().debugLog("what class is \(controllerName)")

        let viewProperties = [AnalyticsConstants().ACTIVITY:controllerName]
        mixpanel.track(AnalyticsConstants().TIME_IN_ACTIVITY, properties: viewProperties)
        mixpanel.flush()
    }

    //MARK: - User interaction track
    func sendUserInteractedTracking(activity:String,
                                    recording:Bool,
                                    interaction:String,
                                    result:String ) {
        //JSON properties
        let userInteractionsProperties =
        [
                AnalyticsConstants().ACTIVITY : activity,
                AnalyticsConstants().RECORDING: recording,
                AnalyticsConstants().INTERACTION: interaction,
                AnalyticsConstants().RESULT: result,
        ]

        mixpanel.track(AnalyticsConstants().USER_INTERACTED, properties: userInteractionsProperties as [NSObject : AnyObject])
    }

    func sendFilterSelectedTracking(name:String,
                                    code:String,
                                    recording:Bool) {
        //JSON properties
        let userInteractionsProperties =
        [
                AnalyticsConstants().TYPE: AnalyticsConstants().FILTER_TYPE_COLOR,
                AnalyticsConstants().NAME: name,
                AnalyticsConstants().CODE: code,
                AnalyticsConstants().RECORDING: recording,
        ]

        mixpanel.track(AnalyticsConstants().FILTER_SELECTED, properties: userInteractionsProperties as [NSObject : AnyObject])
    }

    //MARK: - Google Analytics
    func sendControllerGAITracker(controllerName:String){
        Utils().debugLog("Send controller GoogleAnalytics Tracking")

        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: controllerName)

        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
}
