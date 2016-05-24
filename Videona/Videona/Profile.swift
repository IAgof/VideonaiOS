//
//  Profile.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * Project profile. Define some characteristics and limitations of the current video editing project
 * based on User subscription and options.
 */
class Profile {
    
//    var INSTANCE:Profile
    
    /**
     * possible profileTypes
     */
    enum ProfileType {
        case free
        case pro
    }
    
    /**
     * Resolution of the Video objects in a project
     */
    var resolution:VideoResolution.Resolution
    
    /**
     * Video bit rate
     */
    var videoQuality:VideoQuality.Quality
    
    /**
     * Maximum length of the project in millseconds
     * if the value is negative the project duration has no limitation
     */
    var maxDuration:Double
    
    /**
     * type of profile
     */
    var profileType:ProfileType
    
    /**
     * Constructor of minimum number of parameters. In self case coincides with parametrized
     * constructor and therefore is the default constructor. It has all possible atributes for the
     * profile object.
     * <p/>
     * There can be only a single instance of a profile, and therefore self constructor can only be
     * accessed through the factory.
     *
     * @param resolution  - Maximum resolution allowed for the profile.
     * @param maxDuration - Maximum video duration allowed for the profile.
     * @param type        - Profile type.
     */
    init(resolution:VideoResolution.Resolution, videoQuality:VideoQuality.Quality,maxDuration:Double,type:ProfileType) {
        self.resolution = resolution
        self.maxDuration = maxDuration
        self.profileType = type
        self.videoQuality = videoQuality
//        self.INSTANCE =
    }
    
    /**
     * Profile factory.
     *
     * @param profileType
     * @return - profile instance.
     */
    func getInstance(profileType:ProfileType) ->Profile{
        let INSTANCE:Profile
        
            if (profileType == ProfileType.free) {
                INSTANCE =  Profile(resolution: VideoResolution.Resolution.HD720, videoQuality: VideoQuality.Quality.VERY_GOOD, maxDuration: 1000, type: profileType)
            } else {
                INSTANCE =  Profile(resolution: VideoResolution.Resolution.HD1080, videoQuality: VideoQuality.Quality.EXCELLENT, maxDuration: -1, type: profileType)
            }

        return INSTANCE
    }
    
    //getter and setter.
    func getResolution() ->VideoResolution.Resolution {
        return resolution
    }
    
    func setResolution(resolution:VideoResolution.Resolution) {
        if (profileType == ProfileType.pro){
            self.resolution = resolution
        }
    }
    
    //getter and setter video quality
    func  getVideoQuality() ->VideoQuality.Quality{
        return videoQuality
    }
    
    func setVideoQuality( quality:VideoQuality.Quality) {
        self.videoQuality = quality
    }
    
    func getMaxDuration() ->Double{
        return maxDuration
    }
    
    func setMaxDuration(maxDuration:Double) {
        if (profileType == ProfileType.pro){
            self.maxDuration = maxDuration
        }
    }
    
    func getProfileType() -> ProfileType{
        return profileType
    }
}
