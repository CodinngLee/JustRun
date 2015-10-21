//
//  HomeView.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "HomeView.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@implementation HomeView

- (void)addSubviews {
    [self addSubview:self.totalDistanceStrLabel];
    [self addSubview:self.totalDistanceValLabel];
    
    [self addSubview:self.totalCalorieStrLabel];
    [self addSubview:self.totalCalorieValLabel];
    
    [self addSubview:self.paceStrLabel];
    [self addSubview:self.paceValLabel];
    
    [self addSubview:self.totalNumberStrLabel];
    [self addSubview:self.totalNumberValLabel];
    
    [self addSubview:self.averageDistanceStrLabel];
    [self addSubview:self.averageDistanceValLabel];
    
    [self addSubview:self.goBtn];
}

- (void)defineLayout {
    [self.totalDistanceStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        
        make.top.equalTo(@(self.totalDistanceStrLabel.cas_marginTop));
        make.width.equalTo(@(self.totalDistanceStrLabel.cas_sizeWidth));
        make.height.equalTo(@(self.totalDistanceStrLabel.cas_sizeHeight));
    }];
    
    [self.totalDistanceValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.totalDistanceStrLabel).with.offset(-50);
    }];
    
    [self.totalCalorieStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        
        make.top.equalTo(@(self.totalCalorieStrLabel.cas_marginTop));
        make.width.equalTo(@(self.totalCalorieStrLabel.cas_sizeWidth));
        make.height.equalTo(@(self.totalCalorieStrLabel.cas_sizeHeight));
    }];
    
    [self.totalCalorieValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.totalCalorieStrLabel).with.offset(-50);
        make.top.equalTo(@(self.totalCalorieValLabel.cas_marginTop));
    }];
    
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.width.equalTo(@200);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-80);
    }];
    
    //跑步次数label
    [self.totalNumberStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.goBtn).with.offset(-80);
        make.height.equalTo(@40);
    }];
    
    [self.totalNumberValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.totalNumberStrLabel);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.totalNumberStrLabel).with.offset(-20);
    }];
    
    [self.paceStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalNumberStrLabel);
        make.left.equalTo(self.totalNumberStrLabel).with.offset(-120);
    }];
    
    [self.paceValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalNumberValLabel);
        make.left.equalTo(self.totalNumberValLabel).with.offset(-120);
    }];
    
    [self.averageDistanceStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalNumberStrLabel);
        make.right.equalTo(self.totalNumberStrLabel).with.offset(120);
    }];
    
    [self.averageDistanceValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalNumberValLabel);
        make.right.equalTo(self.totalNumberValLabel).with.offset(120);
    }];

}

- (UILabel *)totalDistanceStrLabel
{
    if (!_totalDistanceStrLabel) {
        _totalDistanceStrLabel = [UILabel new];
        _totalDistanceStrLabel.text = @"总公里";
        _totalDistanceStrLabel.cas_styleClass = @"totalDistanceStrLabel";
        _totalDistanceStrLabel.textColor = [UIColor blackColor];
        _totalDistanceStrLabel.font = [UIFont boldFlatFontOfSize:30];
    }
    
    return _totalDistanceStrLabel;
}

- (UILabel *)totalDistanceValLabel
{
    if (!_totalDistanceValLabel) {
        _totalDistanceValLabel = [UILabel new];
        _totalDistanceValLabel.text = @"";
        _totalDistanceValLabel.textColor = [UIColor blackColor];
        _totalDistanceValLabel.cas_styleClass = @"totalDistanceValLabel";
        _totalDistanceValLabel.font = [UIFont boldFlatFontOfSize:80];
    }
    
    return _totalDistanceValLabel;
}

- (UILabel *)totalCalorieStrLabel
{
    if (!_totalCalorieStrLabel) {
        _totalCalorieStrLabel = [UILabel new];
        _totalCalorieStrLabel.text = @"总卡路里";
        _totalCalorieStrLabel.textColor = [UIColor blackColor];
        _totalCalorieStrLabel.cas_styleClass = @"totalCalorieStrLabel";
        _totalCalorieStrLabel.font = [UIFont boldFlatFontOfSize:30];
    }
    
    return _totalCalorieStrLabel;
}

- (UILabel *)totalCalorieValLabel
{
    if (!_totalCalorieValLabel) {
        _totalCalorieValLabel = [UILabel new];
        _totalCalorieValLabel.text = @"";
        _totalCalorieValLabel.textColor = [UIColor blackColor];
        _totalCalorieValLabel.cas_styleClass = @"totalCalorieValLabel";
        _totalCalorieValLabel.font = [UIFont boldFlatFontOfSize:60];
    }
    
    return _totalCalorieValLabel;
}

- (UILabel *)paceStrLabel
{
    if (!_paceStrLabel) {
        _paceStrLabel = [UILabel new];
        _paceStrLabel.text = @"平均配速";
        _paceStrLabel.textColor = [UIColor blackColor];
//        _paceStrLabel.cas_styleClass = @"paceStrLabel";
        _paceStrLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _paceStrLabel;
}

- (UILabel *)paceValLabel
{
    if (!_paceValLabel) {
        _paceValLabel = [UILabel new];
        _paceValLabel.text = @"";
        _paceValLabel.textColor = [UIColor blackColor];
        //_paceValLabel.cas_styleClass = @"paceValLabel";
        _paceValLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _paceValLabel;
}

- (UILabel *)totalNumberStrLabel
{
    if (!_totalNumberStrLabel) {
        _totalNumberStrLabel = [UILabel new];
        _totalNumberStrLabel.text = @"跑步次数";
        _totalNumberStrLabel.textColor = [UIColor blackColor];
//        _totalNumberStrLabel.cas_styleClass = @"totalNumberStrLabel";
        _totalNumberStrLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _totalNumberStrLabel;
}

- (UILabel *)totalNumberValLabel
{
    if (!_totalNumberValLabel) {
        _totalNumberValLabel = [UILabel new];
        _totalNumberValLabel.text = @"";
        _totalNumberValLabel.textColor = [UIColor blackColor];
//        _totalNumberValLabel.cas_styleClass = @"totalNumberValLabel";
        _totalNumberValLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _totalNumberValLabel;
}

- (UILabel *)averageDistanceStrLabel
{
    if (!_averageDistanceStrLabel) {
        _averageDistanceStrLabel = [UILabel new];
        _averageDistanceStrLabel.text = @"平均跑量";
        _averageDistanceStrLabel.textColor = [UIColor blackColor];
//        _averageDistanceStrLabel.cas_styleClass = @"averageDistanceStrLabel";
        _averageDistanceStrLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _averageDistanceStrLabel;
}

- (UILabel *)averageDistanceValLabel
{
    if (!_averageDistanceValLabel) {
        _averageDistanceValLabel = [UILabel new];
        _averageDistanceValLabel.text = @"";
        _averageDistanceValLabel.textColor = [UIColor blackColor];
//        _averageDistanceValLabel.cas_styleClass = @"averageDistanceValLabel";
        _averageDistanceValLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _averageDistanceValLabel;
}

- (FUIButton *)goBtn
{
    if (!_goBtn) {
        _goBtn = [FUIButton new];
        [_goBtn setTitle:@"开始跑步" forState:UIControlStateNormal];
        _goBtn.buttonColor = [UIColor turquoiseColor];
        _goBtn.shadowColor = [UIColor greenSeaColor];
        _goBtn.shadowHeight = 3.0f;
        _goBtn.cornerRadius = 6.0f;
        _goBtn.titleLabel.font = [UIFont boldFlatFontOfSize:40];
        [_goBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [_goBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    }
    
    return _goBtn;
}

@end