//
//  RunningView.m
//  JustRun
//
//  Created by liyongjie on 9/22/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RunningView.h"
#import "CommonUtil.h"
#import "UIImage+Util.h"

@implementation RunningView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubviews];
        [self defineLayout];

        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.currentDistanceLabel];
    [self addSubview:self.currentPaceLabel];
    
    [self addSubview:self.currentTimeCostLabel];
    [self addSubview:self.milesLabel];
    
    [self addSubview:self.pauseOrContinueBtn];
    [self addSubview:self.lockBtn];
    
    [self addSubview:self.goMapBtn];
    [self addSubview:self.motionTypeLabel];
}

- (void)defineLayout {

    [self.milesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.currentDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.milesLabel);
        make.top.equalTo(self.milesLabel).with.offset(-50);
    }];
    
    [self.currentPaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.currentDistanceLabel).with.offset(-50);
        make.centerY.equalTo(self.currentDistanceLabel).with.offset(-50);
    }];
    
    [self.currentTimeCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.currentDistanceLabel).with.offset(50);
        make.centerY.equalTo(self.currentDistanceLabel).with.offset(-50);
    }];
    
    [self.pauseOrContinueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.milesLabel).with.offset(50);
        make.centerX.equalTo(self.milesLabel);
        make.width.equalTo(@(150));
        make.height.equalTo(@(30));
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pauseOrContinueBtn).with.offset(50);
        make.centerX.equalTo(self.pauseOrContinueBtn);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];

    [self.goMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentDistanceLabel).with.offset(20);
        make.centerX.equalTo(self.currentDistanceLabel).with.offset(80);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    [self.motionTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentDistanceLabel).with.offset(-200);
        make.centerX.equalTo(self.currentDistanceLabel);
    }];

//    FUIButton *btn1 = [FUIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn1.frame = CGRectMake(150, 350, 60, 60);
//    
//    [btn1 setTitle:@"启动" forState:UIControlStateNormal];
//    btn1.layer.borderWidth = 1;
//    btn1.layer.borderColor = [UIColor greenColor].CGColor;
//    btn1.layer.cornerRadius = 30;
//    btn1.layer.masksToBounds = YES;
//    [btn1 setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
//    [self addSubview:btn1];

}

- (FUIButton *)pauseOrContinueBtn
{
    if (!_pauseOrContinueBtn) {
        _pauseOrContinueBtn = [FUIButton new];
        [_pauseOrContinueBtn setTitle:@"" forState:UIControlStateNormal];
        _pauseOrContinueBtn.buttonColor = [UIColor darkGrayColor];
        UIImage *btnImage = [[FAKIonIcons pauseIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
//        btnImage = [UIImage fillWhite:btnImage];
        [_pauseOrContinueBtn setImage:btnImage forState:UIControlStateNormal];
//        _pauseOrContinueBtn.shadowColor = [UIColor greenSeaColor];
//        _pauseOrContinueBtn.shadowHeight = 3.0f;
        _pauseOrContinueBtn.cornerRadius = 1.0f;
//        _pauseOrContinueBtn.titleLabel.font = [UIFont boldFlatFontOfSize:40];
        [_pauseOrContinueBtn setTintColor:[UIColor colorWithPatternImage:btnImage]];
        [_pauseOrContinueBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [_pauseOrContinueBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    }

    return _pauseOrContinueBtn;
}

- (UILabel *)currentDistanceLabel
{
    if (!_currentDistanceLabel) {
        _currentDistanceLabel = [UILabel new];
        _currentDistanceLabel.textColor = [UIColor whiteColor];
        _currentDistanceLabel.text = @"0.00";
        _currentDistanceLabel.font = [UIFont boldFlatFontOfSize:48];
    }
    return _currentDistanceLabel;
}

- (UILabel *)currentPaceLabel
{
    if (!_currentPaceLabel) {
        _currentPaceLabel = [UILabel new];
        _currentPaceLabel.text = @"";
        _currentPaceLabel.textColor = [UIColor whiteColor];
        _currentPaceLabel.font = [UIFont boldFlatFontOfSize:15];
    }
    return _currentPaceLabel;
}

- (UILabel *)currentTimeCostLabel
{
    if (!_currentTimeCostLabel) {
        _currentTimeCostLabel = [UILabel new];
        _currentTimeCostLabel.text = @"00:00:00";
        _currentTimeCostLabel.textColor = [UIColor whiteColor];
        _currentTimeCostLabel.font = [UIFont boldFlatFontOfSize:15];
    }
    return _currentTimeCostLabel;
}

- (UILabel *)milesLabel
{
    if (!_milesLabel) {
        _milesLabel = [UILabel new];
        _milesLabel.textColor = [UIColor whiteColor];
        _milesLabel.text = @"Miles";
        _milesLabel.font = [UIFont boldFlatFontOfSize:20];
    }
    return _milesLabel;
}

- (UILabel *)motionTypeLabel
{
    if (!_motionTypeLabel) {
        _motionTypeLabel = [UILabel new];
        _motionTypeLabel.textColor = [UIColor whiteColor];
        _motionTypeLabel.text = @"";
        _motionTypeLabel.font = [UIFont boldFlatFontOfSize:20];
    }
    return _motionTypeLabel;
}

- (CircularLock *)lockBtn
{
    if (!_lockBtn) {
        _lockBtn = [[CircularLock alloc] initWithCenter:CGPointMake(40, 40)
                                                        radius:20
                                                      duration:1.5
                                                   strokeWidth:3
                                                     ringColor:[UIColor greenColor]
                                                   strokeColor:[UIColor whiteColor]
                                                   lockedImage:[[FAKIonIcons iosLockedIconWithSize:60] imageWithSize:CGSizeMake(60, 60)]
                                                 unlockedImage:[[FAKIonIcons unlockedIconWithSize:20] imageWithSize:CGSizeMake(20, 20)]
                                                      isLocked:YES
                                             didlockedCallback:^{
                                             }
                                           didUnlockedCallback:^{
                                           }];
        _lockBtn.layer.borderWidth = 1;
        _lockBtn.layer.borderColor = [[UIColor greenColor] CGColor];
//        _lockBtn = [[CircularLock alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
//        _lockBtn.frame = CGRectMake(0, 0, 200, 200);
//        _lockBtn.lockedImage = [[FAKIonIcons iosLockedIconWithSize:20] imageWithSize:CGSizeMake(20, 20)];
//        _lockBtn.unlockedImage = [[FAKIonIcons unlockedIconWithSize:20] imageWithSize:CGSizeMake(20, 20)];
//        _lockBtn.strokeWidth = 3;
//        _lockBtn.locked = YES;
//        _lockBtn.radius = 10;
//        _lockBtn.centralView = button;
//        _lockBtn.tintColor = [UIColor whiteColor];
//        _lockBtn.fillOnTouch = YES;
//        _lockBtn.borderWidth = 2.0;
//        _lockBtn.lineWidth = 10.0;
//        _lockBtn.opaque = NO;
    }
    return _lockBtn;
}

- (FUIButton *)goMapBtn
{
    if (!_goMapBtn) {
        _goMapBtn = [FUIButton new];
        [_goMapBtn setTitle:@"" forState:UIControlStateNormal];
        _goMapBtn.buttonColor = [UIColor clearColor];
        UIImage *btnImage = [[FAKIonIcons mapIconWithSize:20] imageWithSize:CGSizeMake(20, 20)];
        //        btnImage = [UIImage fillWhite:btnImage];
        [_goMapBtn setImage:btnImage forState:UIControlStateNormal];
        //        _pauseOrContinueBtn.shadowColor = [UIColor greenSeaColor];
        //        _pauseOrContinueBtn.shadowHeight = 3.0f;
        _goMapBtn.cornerRadius = 10.0f;
        //        _pauseOrContinueBtn.titleLabel.font = [UIFont boldFlatFontOfSize:40];
        [_goMapBtn setTintColor:[UIColor colorWithPatternImage:btnImage]];
        [_goMapBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [_goMapBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    }
    
    return _goMapBtn;
}

@end
