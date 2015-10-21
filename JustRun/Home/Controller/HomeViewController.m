//
//  HomeViewController.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "SFCountdownView.h"
#import "RunningViewController.h"
#import "Activity.h"
#import "SportMathUtils.h"
#import "UIColor+Util.h"

@interface HomeViewController () <SFCountdownViewDelegate>
{
    SFCountdownView *countdownView;
    UIView *shadeView;
    double _totalDistance;
    double _totalCalories;
    double _avgPace;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup title
    self.title = @"主页";
    
    self.view = [[HomeView alloc] initWithFrame:self.view.bounds];
    [self loadData];
    [self setUpEvent];
}

- (void)viewDidAppear:(BOOL)animated {
    [self animationLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpEvent {

    __weak typeof (self) weakSelf = self;
    HomeView *hv = (HomeView *)weakSelf.view;
    
    //go按钮的事件
    [hv.goBtn bk_addEventHandler:^(id sender) {

        shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        shadeView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        [weakSelf.view.window addSubview:shadeView];
        shadeView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        
        [UIView animateWithDuration:0.5 animations:^{
            shadeView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finish) {
            countdownView = [[SFCountdownView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            countdownView.delegate = weakSelf;
            countdownView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
            countdownView.backgroundAlpha = 0;
            countdownView.countdownColor = [UIColor whiteColor];
            countdownView.countdownFrom = 3;
            countdownView.finishText = @"Go";
            [countdownView updateAppearance];
            [shadeView addSubview:countdownView];
            
            [countdownView start];
        }];
        
    } forControlEvents:UIControlEventTouchDown];
}

- (void)countdownFinished:(SFCountdownView *)view {
    [view removeFromSuperview];
    [shadeView removeFromSuperview];
    [self.view setNeedsDisplay];
    
    RunningViewController *runningVC = [[RunningViewController alloc] init];
    runningVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:runningVC animated:NO];
}

- (void)animationLabel {
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1: 0.11:0.94];
    animation.fromValue = @(0);
    
    double animationDuration = 2;
    
    animation.toValue = @(_totalDistance);
    animation.duration = animationDuration;
    
    HomeView *hv = (HomeView *)self.view;
    [hv.totalDistanceValLabel pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}

- (void)loadData {
    //累积所有路程之和
    NSArray *activitys = [Activity MR_findAll];
    double totalDuration = 0;
    for (Activity *act in activitys) {
        _totalDistance += [act.distance doubleValue];
        _totalCalories += [act.calories doubleValue];
        totalDuration += [act.duration doubleValue];
    }
    //平均配速
    NSString *paceStr = [SportMathUtils stringifyAvgPaceFromDist:_totalDistance overTime:totalDuration];
    HomeView *hv = (HomeView *)self.view;
    hv.paceValLabel.text = paceStr;
    
    hv.totalCalorieValLabel.text = [NSString stringWithFormat:@"%.2f", _totalCalories];
    hv.totalNumberValLabel.text = [NSString stringWithFormat:@"%ld", activitys.count];
    hv.averageDistanceValLabel.text = [NSString stringWithFormat:@"%.2f", _totalDistance / activitys.count];
}

#pragma mark - animation
- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty propertyWithName:@"TotalDistance"
        initializer:^(POPMutableAnimatableProperty *prop) {
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                UILabel *label = (UILabel *)obj;
                NSNumber *number = @(values[0]);
                int num = [number intValue];
                label.text = [@(num) stringValue];
            };
        }];
}
@end