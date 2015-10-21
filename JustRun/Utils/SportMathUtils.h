//
//  SportMathUtils.h
//  JustRun
//
//  Created by liyongjie on 9/23/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportMathUtils : NSObject
+ (float)caloriesFromDistOther:(float)meters weight:(float)weightVal Time:(int)seconds;
+ (NSNumber *)caloriesFromDist:(float)meters weight:(float)weightVal overTime:(int)seconds;
+ (NSString *)stringifyCaloriesFromDist:(float)meters weight:(float)weightVal overTime:(int)seconds;
+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds;
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;
@end
