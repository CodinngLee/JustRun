//
//  UserPreferences.h
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

// first launch
+ (BOOL)isFirstLaunch;
+ (void)disableFirstLaunch;
+ (void)enableFirstLaunch;
+ (void)setWeight:(NSInteger)weight;
+ (NSInteger)weight;
+ (void)setHeight:(NSInteger)height;
+ (NSInteger)height;
+ (void)setAge:(NSInteger)age;
+ (NSInteger)age;
+ (void)setRunOfAge:(NSInteger)runOfAge;
+ (NSInteger)runOfAge;
+ (void)setWaistline:(NSInteger)waistline;
+ (NSInteger)waistline;
+ (void)setArea:(NSString*)area;
+ (NSString*)area;
+ (void)setMyWord:(NSString*)myWord;
+ (NSString*)myWord;
+ (NSInteger)followCount;
+ (void)setFollowCount:(NSInteger)followCount;
+ (NSInteger)fansCount;
+ (void)setFansCount:(NSInteger)fansCount;
@end