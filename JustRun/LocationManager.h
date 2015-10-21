//
//  LocationManager.h
//  JustRun
//
//  Created by liyongjie on 9/22/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface LocationManager : NSObject

@property CLLocationManager *locationManager;
@property (readonly) NSMutableArray *recordedRun;
@property (readonly) NSMutableArray *locationsTimes;
@property (readonly) CLLocation *lastLocation;
@property (readonly) CLLocationSpeed currentSpeed;
@property (readonly) CLLocationSpeed maximumSpeed;
@property (readonly) CLLocationSpeed minimumSpeed;
@property (readonly) float minimumVelocity;
@property (readonly) float maximumVelocity;
@property float distance;

+ (id) sharedManager;

- (void) startRecording;
- (void) stopRecording;

@end
