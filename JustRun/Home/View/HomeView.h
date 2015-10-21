//
//  HomeView.h
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@interface HomeView : SHPAbstractView

//总行程量
@property (strong, nonatomic) UILabel *totalDistanceStrLabel;
@property (strong, nonatomic) UILabel *totalDistanceValLabel;

//卡路里总数
@property (strong, nonatomic) UILabel *totalCalorieStrLabel;
@property (strong, nonatomic) UILabel *totalCalorieValLabel;

//总平均配速
@property (strong, nonatomic) UILabel *paceStrLabel;
@property (strong, nonatomic) UILabel *paceValLabel;

//总次数
@property (strong, nonatomic) UILabel *totalNumberStrLabel;
@property (strong, nonatomic) UILabel *totalNumberValLabel;

//平均跑量
@property (strong, nonatomic) UILabel *averageDistanceStrLabel;
@property (strong, nonatomic) UILabel *averageDistanceValLabel;

@property (strong, nonatomic) FUIButton *goBtn;

@end