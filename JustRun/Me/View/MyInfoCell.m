//
//  MyInfoCell.m
//  JustRun
//
//  Created by liyongjie on 9/23/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "MyInfoCell.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"

@implementation MyInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //self.backgroundColor = [UIColor themeColor];
        
        [self addSubviews];
        [self defineLayout];
        //选中单元格时的背景风格
        self.selectionStyle = UITableViewCellStyleValue2;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
        //以下代码可改变选中单元格时的背景颜色
//        UIView *selectedBackground = [UIView new];
//        selectedBackground.backgroundColor = [UIColor colorWithHex:0xF5FFFA];
//        [self setSelectedBackgroundView:selectedBackground];
    }
    
    return self;
}

- (void)addSubviews {
    [self addSubview:self.infoStrLabel];
    [self addSubview:self.infoValLabel];
//    [self addSubview:self.infoImageView];
}

- (void)defineLayout {
//    [self.infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self).with.offset(5);
//    }];
    
    [self.infoStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(5);
    }];
    
    [self.infoValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-30);
    }];
}

- (UILabel *)infoStrLabel {
    if (!_infoStrLabel) {
        _infoStrLabel = [UILabel new];
        _infoStrLabel.textColor = [UIColor blackColor];
        _infoStrLabel.font = [UIFont systemFontOfSize:15];
    }
    return _infoStrLabel;
}

- (UILabel *)infoValLabel {
    if (!_infoValLabel) {
        _infoValLabel = [UILabel new];
        _infoValLabel.textColor = [UIColor blackColor];
        _infoValLabel.font = [UIFont systemFontOfSize:15];
    }
    return _infoValLabel;
}
@end