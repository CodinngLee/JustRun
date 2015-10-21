//
//  UserPreferences.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "UserPreferences.h"

static NSString *const kIsFirstLaunch = @"isFirstLaunch";

@implementation UserPreferences

#pragma mark - first launch
+ (BOOL)isFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return ![userDefaults boolForKey:kIsFirstLaunch];
}

+ (void)disableFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:kIsFirstLaunch];
}

+ (void)enableFirstLaunch
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:kIsFirstLaunch];
}

+ (void)setWeight:(NSInteger)weight
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:weight forKey:@"weight"];
}

+ (NSInteger)weight
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"weight"];
}

+ (void)setHeight:(NSInteger)height
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:height forKey:@"height"];
}

+ (NSInteger)height
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"height"];
}

+ (void)setAge:(NSInteger)age
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:age forKey:@"age"];
}

+ (NSInteger)age
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"age"];
}

+ (void)setRunOfAge:(NSInteger)runOfAge
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:runOfAge forKey:@"runOfAge"];
}

+ (NSInteger)runOfAge
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"runOfAge"];
}

+ (void)setWaistline:(NSInteger)waistline
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:waistline forKey:@"waistline"];
}

+ (NSInteger)waistline
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"waistline"];
}

+ (void)setArea:(NSString*)area {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:area forKey:@"area"];
}

+ (NSString*)area {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:@"area"]) {
        return @"";
    }
    return [userDefaults stringForKey:@"area"];
}

+ (void)setMyWord:(NSString *)myWord {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:myWord forKey:@"myWord"];
}

+ (NSString *)myWord {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:@"myWord"]) {
        return @"";
    }
    return [userDefaults stringForKey:@"myWord"];
}

+ (NSInteger)followCount
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"followCount"];
}

+ (void)setFollowCount:(NSInteger)followCount
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:followCount forKey:@"followCount"];
}

+ (NSInteger)fansCount
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"fansCount"];
}

+ (void)setFansCount:(NSInteger)fansCount
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:fansCount forKey:@"fansCount"];
}
@end
