//
//  RegisterView.m
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RegisterView.h"
#import "UIColor+Util.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterTableViewCell.h"

#define kPaddingLeftWidth 15.0
#define kRegisterPaddingLeftWidth 18.0

@interface RegisterView()<UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) BOOL captchaNeeded;
@property (strong, nonatomic) FUIButton *registerBtn;
@property (strong, nonatomic) TPKeyboardAvoidingTableView *tpTableView;

@end

@implementation RegisterView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tpTableView = ({
            
            TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            
            [tableView registerClass:[RegisterTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Register_Cell];
            tableView.backgroundColor = [UIColor grayColor];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            tableView;
        });

        self.tpTableView.tableHeaderView = [self customHeaderView];
        self.tpTableView.tableFooterView = [self customFooterView];
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Register_Cell forIndexPath:indexPath];
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
        [cell configWithPlaceholder:@"电子邮箱" andValue:@""];
//        cell.textValueChangedBlock = ^(NSString *valueStr){
//            weakSelf.inputTipsView.valueStr = valueStr;
//            weakSelf.inputTipsView.active = YES;
//            weakSelf.myRegister.email = valueStr;
//        };
//        cell.editDidEndBlock = ^(NSString *textStr){
//            weakSelf.inputTipsView.active = NO;
//        };
    }else if (indexPath.row == 1){
        [cell configWithPlaceholder:@" 个性后缀" andValue:@""];
//        cell.textValueChangedBlock = ^(NSString *valueStr){
//            weakSelf.myRegister.global_key = valueStr;
//        };
    } else {
//        cell.isCaptcha = YES;
        [cell configWithPlaceholder:@" 验证码" andValue:@""];
//        cell.textValueChangedBlock = ^(NSString *valueStr){
//            weakSelf.myRegister.j_captcha = valueStr;
//        };
    }
//    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kLoginPaddingLeftWidth];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;//_captchaNeeded? 3 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Table view Header Footer
- (UIView *)customHeaderView {
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.15 * SCREEN_HEIGHT)];
    headerV.backgroundColor = [UIColor clearColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    //设置字体
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    //文本颜色
    headerLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    //对齐方式
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"让生命跑起来";
    [headerLabel setCenter:headerV.center];
    [headerV addSubview:headerLabel];
    
    return headerV;
}

- (UIView *)customFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    _registerBtn = [FUIButton new];
    _registerBtn.frame = CGRectMake(kRegisterPaddingLeftWidth, 20, SCREEN_WIDTH - kRegisterPaddingLeftWidth * 2, 45);
    _registerBtn.titleLabel.text = @"立即体验";
    //[UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"立即体验" andFrame:CGRectMake(kRegisterPaddingLeftWidth, 20, SCREEN_WIDTH - kRegisterPaddingLeftWidth * 2, 45) target:self action:@selector(sendRegister)];
    [footerV addSubview:_registerBtn];
    
//    RAC(self, footerBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, myRegister.email), RACObserve(self, myRegister.global_key), RACObserve(self, myRegister.j_captcha), RACObserve(self, captchaNeeded)] reduce:^id(NSString *email, NSString *global_key, NSString *j_captcha, NSNumber *captchaNeeded){
//        if ((captchaNeeded && captchaNeeded.boolValue) && (!j_captcha || j_captcha.length <= 0)) {
//            return @(NO);
//        }else{
//            return @((email && email.length > 0) && (global_key && global_key.length > 0));
//        }
//    }];
    
    
//    UITTTAttributedLabel *lineLabel = ({
//        UITTTAttributedLabel *label = [[UITTTAttributedLabel alloc] init];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = [UIColor colorWithHexString:@"0x999999"];
//        label.numberOfLines = 0;
//        label.linkAttributes = kLinkAttributes;
//        label.activeLinkAttributes = kLinkAttributesActive;
//        label.delegate = self;
//        label;
//    });
//    
//    NSString *tipStr = @"点击立即体验，即表示同意《coding服务条款》";
//    lineLabel.text = tipStr;
//    [lineLabel addLinkToTransitInformation:@{@"actionStr" : @"gotoServiceTermsVC"} withRange:[tipStr rangeOfString:@"《coding服务条款》"]];
//    
//    CGRect footerBtnFrame = _footerBtn.frame;
//    lineLabel.frame = CGRectMake(CGRectGetMinX(footerBtnFrame), CGRectGetMaxY(footerBtnFrame) +12, CGRectGetWidth(footerBtnFrame), 12);
//    [footerV addSubview:lineLabel];
    
    return footerV;
}
@end
