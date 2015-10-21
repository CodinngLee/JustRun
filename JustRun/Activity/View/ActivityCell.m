//
//  ActivityCellTableViewCell.m
//  JustRun
//
//  Created by liyongjie on 9/21/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "ActivityCell.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;        //self.backgroundColor = [UIColor themeColor];
        
        [self addSubviews];
        [self defineLayout];
        
        UIView *selectedBackground = [UIView new];
        selectedBackground.backgroundColor = [UIColor colorWithHex:0xF5FFFA];
        [self setSelectedBackgroundView:selectedBackground];
        self.rightUtilityButtons = [self rightButtons];
    }
    
    return self;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] title:@"删除"];
    return rightUtilityButtons;
}

- (void)addSubviews {
    [self addSubview:self.paceLabel];
    [self addSubview:self.distanceLabel];
    [self addSubview:self.durationLabel];
    [self addSubview:self.activityDateLabel];
    [self addSubview:self.distanceUnitLabel];
}

- (void)defineLayout {
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(20);
    }];
    [self.distanceUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.center.equalTo(self.distanceLabel);//.with.offset(10);
        make.right.equalTo(self.distanceLabel).with.offset(30);
        make.bottom.equalTo(self).with.offset(-2);
    }];
    
    [self.paceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.distanceUnitLabel);
        make.left.equalTo(self.distanceUnitLabel).with.offset(40);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.distanceUnitLabel);
        make.right.equalTo(self).with.offset(-5);
    }];
    
    [self.activityDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.equalTo(self).with.offset(20);
    }];
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [UILabel new];
        _distanceLabel.text = @"";
        _distanceLabel.textColor = [UIColor redColor];
        _distanceLabel.font = [UIFont boldFlatFontOfSize:36];
    }
    return _distanceLabel;
}

- (UILabel *)paceLabel {
    if (!_paceLabel) {
        _paceLabel = [UILabel new];
        _paceLabel.text = @"";
        _paceLabel.textColor = [UIColor blackColor];
        //        _averageDistanceValLabel.cas_styleClass = @"averageDistanceValLabel";
        _paceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _paceLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [UILabel new];
        _durationLabel.text = @"";
        _durationLabel.textColor = [UIColor redColor];
        //        _averageDistanceValLabel.cas_styleClass = @"averageDistanceValLabel";
        _durationLabel.font = [UIFont systemFontOfSize:20];
    }
    return _durationLabel;
}

- (UILabel *)activityDateLabel {
    if (!_activityDateLabel) {
        _activityDateLabel = [UILabel new];
        _activityDateLabel.text = @"";
        _activityDateLabel.textColor = [UIColor blackColor];
        //        _averageDistanceValLabel.cas_styleClass = @"averageDistanceValLabel";
        _activityDateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _activityDateLabel;
}

- (UILabel *)distanceUnitLabel {
    if (!_distanceUnitLabel) {
        _distanceUnitLabel = [UILabel new];
        _distanceUnitLabel.text = @"公里";
        _distanceUnitLabel.textColor = [UIColor redColor];
        //        _averageDistanceValLabel.cas_styleClass = @"averageDistanceValLabel";
        _distanceUnitLabel.font = [UIFont systemFontOfSize:16];
    }
    return _distanceUnitLabel;
}
@end
