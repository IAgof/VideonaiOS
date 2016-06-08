//
//  AVResolutionCompatible.m
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 8/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

#import "AVResolutionCompatible.h"

@implementation AVResolutionCompatible

+ (NSDictionary*) cameraResolutions:(NSString*)deviceModel {
    
    // iPhone 4S
    if ([deviceModel isEqualToString:@"iPhone4,1"]
        || [deviceModel isEqualToString:@"iPod touch"]) {
        
        NSString* lFrontCam = @"640x480,480x360,192x144";
        NSString* lBackCam = @"1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPhone 5/5C/5S/6/6+/iPod 6
    else if ([deviceModel isEqualToString:@"iPhone5,1"]
             || [deviceModel isEqualToString:@"iPhone5,2"]
             || [deviceModel isEqualToString:@"iPhone5,3"]
             || [deviceModel isEqualToString:@"iPhone5,4"]
             || [deviceModel isEqualToString:@"iPhone6,1"]
             || [deviceModel isEqualToString:@"iPhone6,2"]
             || [deviceModel isEqualToString:@"iPhone7,1"]
             || [deviceModel isEqualToString:@"iPhone7,2"]
             || [deviceModel isEqualToString:@"iPod7,1"]) {
        
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"3264x2448,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPhone 6S/6S+
    else if ([deviceModel isEqualToString:@"iPhone8,1"]
             || [deviceModel isEqualToString:@"iPhone8,2"]) {
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"4032x3024,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 2
    else if ([deviceModel isEqualToString:@"iPad2,1"]
             || [deviceModel isEqualToString:@"iPad2,2"]
             || [deviceModel isEqualToString:@"iPad2,3"]
             || [deviceModel isEqualToString:@"iPad2,4"]) {
        
        
        NSString* lFrontCam = @"640x480,480x360,192x144";
        NSString* lBackCam = @"1280x720,960x720,480x360,192x144,640x480";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 3
    else if ([deviceModel isEqualToString:@"iPad3,1"]
             || [deviceModel isEqualToString:@"iPad3,2"]
             || [deviceModel isEqualToString:@"iPad3,3"]) {
        
        
        NSString* lFrontCam = @"640x480,480x360,192x144";
        NSString* lBackCam = @"2592x1936,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 4/Air/Mini/Mini 2/Mini 3/iPod 5G
    else if ([deviceModel isEqualToString:@"iPad3,4"]
             || [deviceModel isEqualToString:@"iPad3,5"]
             || [deviceModel isEqualToString:@"iPad3,6"]
             || [deviceModel isEqualToString:@"iPad4,1"]
             || [deviceModel isEqualToString:@"iPad4,2"]
             || [deviceModel isEqualToString:@"iPad4,3"]
             || [deviceModel isEqualToString:@"iPad4,4"]
             || [deviceModel isEqualToString:@"iPad4,5"]
             || [deviceModel isEqualToString:@"iPad4,6"]
             || [deviceModel isEqualToString:@"iPad4,7"]
             || [deviceModel isEqualToString:@"iPad4,8"]
             || [deviceModel isEqualToString:@"iPod5,1"]) {
        
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"2592x1936,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad Air 2/Mini 4/Pro
    else if ([deviceModel isEqualToString:@"iPad5,3"]
             || [deviceModel isEqualToString:@"iPad5,4"]) {
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"3264x2448,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    return nil;
}
@end
