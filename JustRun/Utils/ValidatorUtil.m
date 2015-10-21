//
//  ValidatorUtil.m
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "ValidatorUtil.h"

@implementation ValidatorUtil

//判定邮箱的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//判断电话号码的正则表达式
+ (BOOL)isValidatePhone:(NSString *)phone {
    NSString *emailRegex = @"^(0?1[0-9]\\d{9})$|^((0(10|2[1-3]|[3-9]\\d{2}))-?[1-9]\\d{6,7})$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:phone];
}

@end
