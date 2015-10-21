//
//  User.h
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//用户ID
@property (nonatomic, readwrite, assign) int64_t userID;
//位置
@property (nonatomic, copy) NSString *location;
//昵称
@property (nonatomic, readwrite, copy) NSString *username;
//关注
@property (nonatomic, assign) NSNumber *followCount;
//粉丝数
@property (nonatomic, assign) NSNumber *fansCount;
//关系
@property (nonatomic, assign)           int relationship;
//图像url
@property (nonatomic, readwrite, strong) NSURL *portraitURL;
//性别
@property (nonatomic, copy) NSString *gender;
//注册时间
@property (nonatomic, copy) NSDate *joinTime;
//上次登陆时间
@property (nonatomic, copy) NSDate *latestOnlineTime;
//个性签名
@property (nonatomic, copy) NSString *mySignature;
//身高
@property (nonatomic, copy) NSNumber *height;
//体重
@property (nonatomic, copy) NSNumber *weight;
//腰围
@property (nonatomic, copy) NSNumber *waistline;
//跑龄
@property (nonatomic, copy) NSNumber *runOfAge;
//年龄
@property (nonatomic, copy) NSNumber *age;
@end
