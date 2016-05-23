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
    
    var INSTANCE:Profile
    
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
    var resolution:VideoResolution.resolution
    
    /**
     * Video bit rate
     */
    var videoQuality:VideoQuality.quality
    
    /**
     * Maximum length of the project in millseconds;
     * if the value is negative the project duration has no limitation
     */
    var maxDuration:Double
    
    /**
     * type of profile
     */
    var profileType:ProfileType
    
    /**
     * Constructor of minimum number of parameters. In this case coincides with parametrized
     * constructor and therefore is the default constructor. It has all possible atributes for the
     * profile object.
     * <p/>
     * There can be only a single instance of a profile, and therefore this constructor can only be
     * accessed through the factory.
     *
     * @param resolution  - Maximum resolution allowed for the profile.
     * @param maxDuration - Maximum video duration allowed for the profile.
     * @param type        - Profile type.
     */
    init(resolution:VideoResolution.resolution, VideoQuality.Quality videoQuality, long maxDuration, ProfileType type) {
    this.resolution = resolution;
    this.maxDuration = maxDuration;
    this.profileType = type;
    this.videoQuality = videoQuality;
    }
    
    /**
     * Profile factory.
     *
     * @param profileType
     * @return - profile instance.
     */
    public static Profile getInstance(ProfileType profileType) {
    if (INSTANCE == null) {
    if (profileType == ProfileType.free) {
    INSTANCE = new Profile(VideoResolution.Resolution.HD720, VideoQuality.Quality.VERY_GOOD, 1000, profileType);
    } else {
    INSTANCE = new Profile(VideoResolution.Resolution.HD1080, VideoQuality.Quality.EXCELLENT, -1, profileType);
    }
    }
    return INSTANCE;
    }
    
    //getter and setter.
    public VideoResolution.Resolution getResolution() {
    return resolution;
    }
    
    public void setResolution(VideoResolution.Resolution resolution) {
    if (profileType == ProfileType.pro)
    this.resolution = resolution;
    }
    
    //getter and setter video quality
    public VideoQuality.Quality getVideoQuality() {
    return videoQuality;
    }
    
    public void setVideoQuality(VideoQuality.Quality quality) {
    this.videoQuality = quality;
    }
    
    public long getMaxDuration() {
    return maxDuration;
    }
    
    public void setMaxDuration(long maxDuration) {
    if (profileType == ProfileType.pro)
    this.maxDuration = maxDuration;
    }
    
    public ProfileType getProfileType() {
    return profileType;
    }
}
