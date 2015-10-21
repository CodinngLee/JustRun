//
//  Activity.h
//  JustRun
//
//  Created by liyongjie on 9/21/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSManagedObject

//ID
//@property (nonatomic, readwrite, assign) int64_t ID;
//跑步时间
@property (nonatomic, retain) NSDate *activityDate;
//路程
@property (nonatomic, readwrite, retain) NSNumber *distance;
//持续时间
@property (nonatomic, retain) NSNumber *duration;
//配速
@property (nonatomic, retain) NSNumber *pace;
//时速
@property (nonatomic, retain) NSNumber *mph;
//卡路里
@property (nonatomic, retain) NSNumber *calories;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
//@property (nonatomic, retain) NSOrderedSet *locations;
@property (nonatomic, readonly) NSNumber *minimumSpeed;
@property (nonatomic, readonly) NSNumber *maximumSpeed;
@property (nonatomic, retain) NSMutableArray *locations;
@property (nonatomic, strong) NSString *name;
@end