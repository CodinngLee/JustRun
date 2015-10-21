//
//  LoginView.h
//  JustRun
//
//  Created by liyongjie on 9/28/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) FUIButton *loginButton;
@property (nonatomic, strong) UILabel *separatorLabel;
@property (nonatomic, strong) FUIButton *weiboButton;
@property (nonatomic, strong) FUIButton *wxButton;
@property (nonatomic, strong) FUIButton *qqButton;
@property (nonatomic, strong) UIButton *forgotButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end
