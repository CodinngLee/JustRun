//
//  RunningView.h
//  JustRun
//
//  Created by liyongjie on 9/22/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularLock.h"

@interface RunningView : UIView

//当前已跑行程量
@property (strong, nonatomic) UILabel *currentDistanceLabel;
//当前配速
@property (strong, nonatomic) UILabel *currentPaceLabel;
//当前消耗时间
@property (strong, nonatomic) UILabel *currentTimeCostLabel;
//miles字的label
@property (strong, nonatomic) UILabel *milesLabel;
//暂停继续按钮
@property (strong, nonatomic) FUIButton *pauseOrContinueBtn;
//lock和结束按钮
@property (strong, nonatomic) CircularLock *lockBtn;
//切换进入地图按钮
@property (strong, nonatomic) FUIButton *goMapBtn;
//运动状态
@property (strong, nonatomic) UILabel *motionTypeLabel;
@end
