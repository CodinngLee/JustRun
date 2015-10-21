//
//  RegisterTableViewCell.m
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RegisterTableViewCell.h"
#import "UIColor+Util.h"

#define kRegisterPaddingLeftWidth 18.0

@interface RegisterTableViewCell()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end


@implementation RegisterTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)clearBtnClicked:(id)sender {
    self.textField.text = @"";
    [self textValueChanged:nil];
}

#pragma mark - UIView
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.textField.font = [UIFont systemFontOfSize:17];
    self.textField.textColor = [UIColor colorWithHexString:@"#222222"];
    
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kRegisterPaddingLeftWidth, 43.5, SCREEN_WIDTH-2*kRegisterPaddingLeftWidth, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.5];
        [self.contentView addSubview:_lineView];
    }
    
//    if (_isCaptcha) {
//        [self.textField setWidth:(kScreen_Width - 2*kLoginPaddingLeftWidth) - (_isForLoginVC? 90 : 70)];
//        _captchaView.hidden = NO;
//        [self refreshCaptchaImage];
//    }else{
//        [self.textField setWidth:(kScreen_Width - 2*kLoginPaddingLeftWidth) - (_isForLoginVC? 20:0)];
//        _captchaView.hidden = YES;
//    }
    
//    [self.clearBtn.frame = :CGRectGetMaxX(self.textField.frame) - 10];
    
//    _lineView.hidden = !_isForLoginVC;
    _clearBtn.hidden = YES;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

- (void)textValueChanged:(id)sender {
//    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (void)editDidBegin:(id)sender {
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.clearBtn.hidden = self.textField.text.length <= 0;
}

- (void)editDidEnd:(id)sender {
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.5];
    self.clearBtn.hidden = YES;
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr{
//    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr? phStr: @"" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:_isForLoginVC? @"0xffffff": @"0x999999" andAlpha:_isForLoginVC? 0.5: 1.0]}];
    self.textField.text = valueStr;
}
@end
