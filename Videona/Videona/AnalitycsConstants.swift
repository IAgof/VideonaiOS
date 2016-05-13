//
//  AnalitycsConstants.swift
//  Kamarada
//
//  Created by Alejandro Arjonilla Garcia on 21/4/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


class AnalyticsConstants {
    
    /**
     * Token
     */
    #if DEBUG
    let MIXPANEL_TOKEN = "c6617213110cd2513dfc0ad97dbaee66"
    #else
    let MIXPANEL_TOKEN = "bb9e99661ccafc2a391dc292aa007e75"
    #endif
    
    /**
     * Event Names
     */
    let APP_STARTED = "App Started"
    let VIDEO_RECORDED = "Video Recorded"
    let VIDEO_EXPORTED = "Video Exported"
    let VIDEO_SHARED = "Video Shared"
    let USER_INTERACTED = "User Interacted"
    let FILTER_SELECTED = "Filter Selected"
    let TIME_IN_ACTIVITY = "Time in Activity"
    let BETA_LEAVED = "Beta Leaved"
    let APP_SHARED = "App Shared"
    let LINK_CLICK = "Link Click"
    
    /**
     * User Traits
     */
    let CREATED = "created"
    let TYPE = "type"
    let APP_USE_COUNT = "appUseCount"
    let RESOLUTION = "resolution"
    let QUALITY = "quality"
    let TOTAL_VIDEOS_RECORDED = "totalVideosRecorded"
    let LAST_VIDEO_RECORDED = "lastVideoRecorded"
    let TOTAL_VIDEOS_SHARED = "totalVideosShared"
    let LAST_VIDEO_SHARED = "lastVideoShared"
    let LOCALE = "locale"
    let LANG = "lang"
    
    /**
     * User Traits values
     */
    let USER_TYPE_FREE = "free"
    let USER_TYPE_BETA = "beta user"
    let LAST_GIFT_DOWNLOADED = "lastGiftDownloaded"
    let LAST_GIFT_DOWNLOADED_DATE = "lastGiftDownloadedDate"
    let TOTAL_GIFTS_DOWNLOADED = "totalGiftsDownloaded"
    let TOTAL_FILTERS_USED = "totalFiltersUsed"
    
    /**
     * Super properties
     */
    let FIRST_TIME = "firstTime"
    let APP = "app"
    let FLAVOR = "flavor"
    
    /**
     * Values
     */
    let DATE = "date" // Beta Leaved event property
    let TYPE_ORGANIC = "organic" // App Started event property
    
    let INIT_STATE = "initState" // App Started event property
    let FILTER_TYPE_COLOR = "color"
    let FILTER_TYPE_DISTORTION = "distortion"
    let FILTER_TYPE_OVERLAY = "overlay"
    let ACTIVITY = "activity"
    let RECORDING = "recording"
    let INTERACTION = "interaction"
    let INTERACTION_OPEN_SETTINGS = "settings opened"
    let INTERACTION_OPEN_DRAWER = "drawer opened"
    let RESULT = "result"
    let VIDEO_LENGTH = "videoLength"
    let NUMBER_OF_CLIPS = "numberOfClips"
    let NAME = "name"
    let CODE = "code"
    let CHANGE_FLASH = "change flash"
    let RECORD = "record"
    let START = "start"
    let STOP = "stop"
    let CHANGE_CAMERA = "change camera"
    let CAMERA_BACK = "back"
    let CAMERA_FRONT = "front"
    let SOCIAL_NETWORK = "socialNetwork"
    let CLEAR_FILTER = "clearFilter"
    let SET_FILTER_GROUP = "setFilterGroup"
    let FILTER_GROUP_OVERLAY = "overlay"
    let FILTER_GROUP_SHADER = "shader"
    let FILTERS_COMBINED = "filtersCombined"
    let COMBINED = "combined"
    
    let INIT_STATE_FIRST_TIME = "firstTime"
    let INIT_STATE_RETURNING = "returning"
    let INIT_STATE_UPGRADE = "upgrade"
    let APP_SHARED_NAME = "appShared"
    let LINK = "link"
    let SOURCE_APP = "sourceApp"
    let DESTINATION = "destination"
    let SOURCE_APP_VIDEONA = "Videona"
    let DESTINATION_KAMARADA_PLAY = "Kamarada Google Play"
}

