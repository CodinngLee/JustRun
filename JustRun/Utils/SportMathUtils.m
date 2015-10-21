//
//  SportMathUtils.m
//  JustRun
//
//  Created by liyongjie on 9/23/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "SportMathUtils.h"

@implementation SportMathUtils

+ (float)caloriesFromDistOther:(float)meters weight:(float)weightVal Time:(int)seconds
{
    float speed = seconds / meters * 40 / 6; //分钟／400米
    return weightVal * 30 / speed * seconds / 3600;
    //跑步热量（kcal）＝体重（kg）×运动时间（小时）×指数K  指数K＝30÷速度（分钟/400米）
}

+ (NSNumber *)caloriesFromDist:(float)meters weight:(float)weightVal overTime:(int)seconds {
    float avgVelocity = meters / seconds;
    
    //    x = 0.064 dla predkosci do 2,68224m/s
    //    x=0.079 dla predkosci od 2,68224 do 4,4704 m/s
    //    x=0.1 dla prędkości od 4,4704m/s do 5,36448056 m/s
    //    x=0.13 dla prędkości od 5,36448056 m/s
    
    float xFactor = 0;
    if (avgVelocity < 2.68224) {
        xFactor = 0.064;
    } else if (avgVelocity < 4.4704) {
        xFactor = 0.079;
    } else if (avgVelocity < 5.36448056) {
        xFactor = 0.1;
    } else {
        xFactor = 0.13;
    }
    
    float weight = weightVal;
    float kcal = xFactor * seconds / 60 * weight * 2.20462262;
    return [NSNumber numberWithFloat:kcal];
}

+ (NSString *)stringifyCaloriesFromDist:(float)meters weight:(float)weightVal overTime:(int)seconds {
    return [NSString stringWithFormat:@"kcal: %.2f", [[self caloriesFromDist:meters weight:weightVal overTime:seconds] floatValue]];
}

+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds
{
    if (seconds == 0 || meters == 0) {
        return @"0 min/km";
    }
    
    float avgPaceSecMeters = seconds / meters;
    
    int paceMin = (int) (avgPaceSecMeters / 60);
    int paceSec = (int) (avgPaceSecMeters - (paceMin * 60));
    
    NSString *unitName = @"min/km";
    return [NSString stringWithFormat:@"%i:%02i %@", paceMin, paceSec, unitName];
}

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat
{
    int remainingSeconds = seconds;
    int hours = remainingSeconds / 3600;
    remainingSeconds = remainingSeconds - hours * 3600;
    int minutes = remainingSeconds / 60;
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if (longFormat) {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, remainingSeconds];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%imin %isec", minutes, remainingSeconds];
        } else {
            return [NSString stringWithFormat:@"%isec", remainingSeconds];
        }
    } else {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, remainingSeconds];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%02i:%02i", minutes, remainingSeconds];
        } else {
            return [NSString stringWithFormat:@"00:%02i", remainingSeconds];
        }
    }
}

@end