//
// Created by Alejandro Arjonilla Garcia on 21/6/16.
// Copyright (c) 2016 Videona. All rights reserved.
//

import Foundation
import Mixpanel

class VideonaTracker {
    let mixpanel = Mixpanel.sharedInstanceWithToken(AnalyticsConstants().MIXPANEL_TOKEN)
    let preferences = NSUserDefaults.standardUserDefaults()

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

    //MARK: - Filter selected
    func sendFilterSelectedTracking(type:String,
                                    name:String,
                                    code:String,
                                    isRecording:Bool,
                                    combined:Bool,
                                    filtersCombined:[String]) {
        //JSON properties
        let userInteractionsProperties =
            [
                AnalyticsConstants().TYPE: type,
                AnalyticsConstants().NAME: name,
                AnalyticsConstants().CODE: code,
                AnalyticsConstants().RECORDING: isRecording,
                AnalyticsConstants().COMBINED: combined,
                AnalyticsConstants().FILTERS_COMBINED: filtersCombined,
                ]
        mixpanel.track(AnalyticsConstants().FILTER_SELECTED, properties: userInteractionsProperties as [NSObject : AnyObject])
    }
    
    //MARK: - App Shared
    func trackAppShared( appName:String,  socialNetwork:String) {
        let appSharedProperties =
            [
                AnalyticsConstants().APP_SHARED_NAME: appName,
                AnalyticsConstants().SOCIAL_NETWORK: socialNetwork
        ]
        mixpanel.track(AnalyticsConstants().APP_SHARED, properties: appSharedProperties as [NSObject : AnyObject])
    }

    //MARK: - Video Shared
    func trackVideoShared(socialNetwork:String,
                          videoDuration:Double,
                          numberOfClips:Int) {
        
        self.updateNumTotalVideosShared()

        trackVideoSharedSuperProperties()
        
        mixpanel.identify(Utils().udid)
        
        //JSON properties
        let socialNetworkProperties =
            [
                AnalyticsConstants().SOCIAL_NETWORK : socialNetwork,
                AnalyticsConstants().VIDEO_LENGTH: videoDuration,
                AnalyticsConstants().RESOLUTION: getResolutionSaved(),
                AnalyticsConstants().NUMBER_OF_CLIPS: numberOfClips,
                AnalyticsConstants().TOTAL_VIDEOS_SHARED: getNumTotalVideosShared(),
                AnalyticsConstants().DOUBLE_HOUR_AND_MINUTES: Utils().getDoubleHourAndMinutes(),
                ]
        mixpanel.track(AnalyticsConstants().VIDEO_SHARED, properties: socialNetworkProperties as [NSObject : AnyObject])
        
        mixpanel.people.increment(AnalyticsConstants().TOTAL_VIDEOS_SHARED,by: NSNumber.init(int: Int32(1)))
        mixpanel.people.set(AnalyticsConstants().LAST_VIDEO_SHARED,to: Utils().giveMeTimeNow())
    }
    
    func trackVideoSharedSuperProperties() {
        var numPreviousVideosShared:Int
        let properties = mixpanel.currentSuperProperties()
        
        if let prop = properties[AnalyticsConstants().TOTAL_VIDEOS_SHARED]{
            numPreviousVideosShared = prop as! Int
        }else{
            numPreviousVideosShared = 0
        }
        
        numPreviousVideosShared += 1
        
        //JSON properties
        
        let updateSuperProperties = [AnalyticsConstants().TOTAL_VIDEOS_SHARED: numPreviousVideosShared]
        
        mixpanel.registerSuperProperties(updateSuperProperties)
    }
    
    //MARK: - Video Recorded
    func trackTotalVideosRecordedSuperProperty() {
        var numPreviousVideosRecorded:Int
        let properties = mixpanel.currentSuperProperties()
        
        if let prop = properties[AnalyticsConstants().TOTAL_VIDEOS_RECORDED]{
            numPreviousVideosRecorded = prop as! Int
        }else{
            numPreviousVideosRecorded = 0
        }
        
        numPreviousVideosRecorded += 1
        
        //JSON properties
        
        let totalVideoRecordedSuperProperty = [AnalyticsConstants().TOTAL_VIDEOS_RECORDED: numPreviousVideosRecorded]
        
        mixpanel.registerSuperProperties(totalVideoRecordedSuperProperty)
    }
    
    func sendVideoRecordedTracking(videoLenght:Double) {
        
        let totalVideosRecorded = getTotalVideosRecordedSaved()
        let resolution = getResolutionSaved()
        
        //JSON properties
        let videoRecordedProperties =
            [
                AnalyticsConstants().VIDEO_LENGTH: videoLenght,
                AnalyticsConstants().RESOLUTION: resolution,
                AnalyticsConstants().TOTAL_VIDEOS_RECORDED: totalVideosRecorded,
                AnalyticsConstants().DOUBLE_HOUR_AND_MINUTES: Utils().getDoubleHourAndMinutes()
        ]
        mixpanel.track(AnalyticsConstants().VIDEO_RECORDED, properties: videoRecordedProperties as [NSObject : AnyObject])
        self.updateUserProfileProperties()
    }
    
    //MARK: - Video Exported
    func sendExportedVideoMetadataTracking(videoLenght:Double,
                                           numberOfClips:Int) {
        
        let resolution = getResolutionSaved()

        let videoRecordedProperties =
            [
                AnalyticsConstants().VIDEO_LENGTH: videoLenght,
                AnalyticsConstants().RESOLUTION: resolution,
                AnalyticsConstants().NUMBER_OF_CLIPS:numberOfClips ,
                AnalyticsConstants().DOUBLE_HOUR_AND_MINUTES: Utils().getDoubleHourAndMinutes(),
                ]
        mixpanel.track(AnalyticsConstants().VIDEO_EXPORTED, properties: videoRecordedProperties as [NSObject : AnyObject])
    }
    
    func updateUserProfileProperties() {
        Utils().debugLog("updateUserProfileProperties")
        mixpanel.identify(Utils().udid)
        
        let quality = getQualitySaved()
        let resolution = getResolutionSaved()
        
        //JSON properties
        let userProfileProperties =
            [
                AnalyticsConstants().RESOLUTION: resolution,
                AnalyticsConstants().QUALITY: quality,
                ]
        
        mixpanel.people.set(userProfileProperties)
        mixpanel.people.increment(AnalyticsConstants().TOTAL_VIDEOS_RECORDED,by: NSNumber.init(int: Int32(1)))
        mixpanel.people.set([AnalyticsConstants().LAST_VIDEO_RECORDED:Utils().giveMeTimeNow()])
        
    }
    
    //MARK: - Google Analytics
    func sendControllerGAITracker(controllerName:String){
        Utils().debugLog("Send controller GoogleAnalytics Tracking")

        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: controllerName)

        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    //MARK: - Get saved params
    private func getQualitySaved() -> String {
        var quality = ""
        if preferences.objectForKey(ConfigPreferences().QUALITY_SAVED) != nil {
            quality = preferences.stringForKey(ConfigPreferences().QUALITY_SAVED)!
        }
        return quality
    }
    
    private func getResolutionSaved() -> String {
        var resolution = ""
        if preferences.stringForKey(ConfigPreferences().RESOLUTION_SAVED) != nil {
            resolution = preferences.stringForKey(ConfigPreferences().RESOLUTION_SAVED)!
            resolution = resolution.stringByReplacingOccurrencesOfString(ConfigPreferences().RESOLUTION_PREFIX,
                                                                         withString:"")
        }
        return resolution
    }
    
    private func getTotalVideosRecordedSaved() -> Int {
        var totalVideos = 0
        if preferences.objectForKey(ConfigPreferences().TOTAL_VIDEOS_RECORDED) != nil {
            totalVideos = preferences.integerForKey(ConfigPreferences().TOTAL_VIDEOS_RECORDED)
        }
        return totalVideos
    }
    
    func getNumTotalVideosShared() -> Int {
        return preferences.integerForKey(ConfigPreferences().TOTAL_VIDEOS_SHARED)
    }
    
    //MARK: - Update params
    func updateTotalVideosRecorded() {
        var numTotalVideosRecorded = preferences.integerForKey(ConfigPreferences().TOTAL_VIDEOS_RECORDED)
        numTotalVideosRecorded += 1
        
        preferences.setInteger(numTotalVideosRecorded, forKey: ConfigPreferences().TOTAL_VIDEOS_RECORDED)
    }
    
    func updateNumTotalVideosShared(){
        var totalVideosShared = preferences.integerForKey(ConfigPreferences().TOTAL_VIDEOS_SHARED)
        totalVideosShared += 1
        preferences.setInteger(totalVideosShared, forKey: ConfigPreferences().TOTAL_VIDEOS_SHARED)
    }
}
