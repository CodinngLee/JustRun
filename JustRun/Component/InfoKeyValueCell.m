//
//  InfoKeyValueCell.m
//  JustRun
//
//  Created by liyongjie on 9/23/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "InfoKeyValueCell.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"

@implementation InfoKeyValueCell

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
    }
    
    return self;
}

- (void)addSubviews {
    [self addSubview:self.infoKeyLabel];
    [self addSubview:self.infoValLabel];
}

- (void)defineLayout {
    [self.infoKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(5);
    }];
    
    [self.infoValLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-30);
    }];
}

- (UILabel *)infoStrLabel {
    if (!_infoKeyLabel) {
        _infoKeyLabel = [UILabel new];
        _infoKeyLabel.textColor = [UIColor blackColor];
        _infoKeyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _infoKeyLabel;
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