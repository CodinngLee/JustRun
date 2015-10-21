//
//  AppConfigure.h
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfigure : NSObject

+ (id)objectForKey:(NSString *)key;
+ (NSString *)valueForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)setObject:(id)value ForKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

@end
