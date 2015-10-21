//
//  CommonUtil.h
//  OpenRaiden
//
//  Created by liyongjie on 9/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject
+ (NSString *)createUUID;
+ (long long)next;
+ (NSArray *) getAllLanguages;
+ (NSString *)getGUIDPath;
+ (NSString *) getTemporaryDirectory;
+ (NSInteger)networkStatus;
+ (MBProgressHUD *)createHUD;
+ (void)tip:(NSString *)tipStr;
+ (NSString *)formatterDate:(NSDate *)date withFormat:(NSString *)format;
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval shortDate:(BOOL)shortDate;
@end
