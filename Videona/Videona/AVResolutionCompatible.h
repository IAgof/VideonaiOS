//
//  AVResolutionCompatible.h
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 8/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVResolutionCompatible : NSObject
+ (NSDictionary*) cameraResolutions:(NSString*)deviceModel;
@end
