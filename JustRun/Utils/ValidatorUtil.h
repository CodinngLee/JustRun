//
//  ValidatorUtil.h
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatorUtil : NSObject

+ (BOOL)isValidatePhone:(NSString *)phone;
+ (BOOL)isValidateEmail:(NSString *)email;

@end
