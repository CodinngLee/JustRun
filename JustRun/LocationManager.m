//
//  LocationManager.m
//  JustRun
//
//  Created by liyongjie on 9/22/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager() <CLLocationManagerDelegate>

@property BOOL isRecording;

@end

@implementation LocationManager

#pragma mark Init methods

- (id) init {
    self = [super init];
    
    if (self) {
        self.isRecording = NO;
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        
        [self.locationManager startUpdatingLocation];
    }
    
    return self;
}

+ (id) sharedManager {
    static LocationManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[LocationManager alloc] init];
    });
    return sharedSingleton;
}

#pragma mark CLLocation delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:locations forKey:@"locations"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdateLocations" object:self userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdateLocations" object:self];
    
    CLLocation *lastLocation = [locations lastObject];
    _lastLocation = lastLocation;
    if (_isRecording) {
        CLLocationSpeed currentSpeed = [lastLocation speed];
        _currentSpeed = currentSpeed;
        NSDate *timestamp = [NSDate date];
        
        [self.recordedRun addObject:lastLocation];
        [self.locationsTimes addObject:timestamp];
        
        if (currentSpeed > _maximumSpeed) {
            _maximumSpeed = currentSpeed;
        }
        
        if (currentSpeed < _minimumSpeed) {
            _minimumSpeed = currentSpeed;
        }
        
        NSInteger recordedRunLocationsCount = self.recordedRun.count;
        if (recordedRunLocationsCount > 1) {
            CLLocation *newerLocation = [self.recordedRun objectAtIndex:recordedRunLocationsCount - 1];
            CLLocation *olderLocation = [self.recordedRun objectAtIndex:recordedRunLocationsCount - 2];
            self.distance += [newerLocation distanceFromLocation:olderLocation];
        }
        
        NSLog(@"min: %.1f, max: %.1f", self.minimumSpeed, self.maximumSpeed);
    }
//    NSLog(@"vertical: %f, horizontal: %f", lastLocation.verticalAccuracy, lastLocation.horizontalAccuracy);
}

- (NSTimeInterval) runTime {
    return [[self.locationsTimes firstObject] timeIntervalSinceDate:[self.locationsTimes lastObject]];
}

- (void) startRecording {
    _isRecording = YES;
    self.distance = 0;
    _recordedRun = [[NSMutableArray alloc] init];
    _locationsTimes = [[NSMutableArray alloc] init];
    _lastLocation = nil;
    _minimumSpeed = 10000;
    _maximumSpeed = 0;
    _currentSpeed = 0;
}

- (void) stopRecording {
    _isRecording = NO;
}


@end
