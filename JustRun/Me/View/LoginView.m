//
//  LoginView.m
//  JustRun
//
//  Created by liyongjie on 9/28/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "LoginView.h"
#import "FAKIcon.h"
#import "FAKIonIcons.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        self.userInteractionEnabled = YES;
        [self defineLayout];
        [self addSubviews];
        
    }
    return self;
}

- (void)addSubviews {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgotButton];
    [self addSubview:self.registerButton];
    [self addSubview:self.usernameField];
    [self addSubview:self.passwordField];
    
    [self addSubview:self.separatorLabel];
    [self addSubview:self.weiboButton];
    [self addSubview:self.wxButton];
    [self addSubview:self.qqButton];
    
}

- (void)defineLayout {
    
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
//    self.backgroundColor = mainColor;
    self.backgroundColor = [UIColor darkGrayColor];
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(25, 228, 263, 41)];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.layer.cornerRadius = 3.0f;
    _usernameField.placeholder = @"Email/Phone";
    _usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [[FAKIonIcons emailIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];//[UIImage imageNamed:@"mail"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    _usernameField.leftViewMode = UITextFieldViewModeAlways;
    _usernameField.leftView = usernameIconContainer;
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(25, 277, 263, 41)];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.layer.cornerRadius = 3.0f;
    _passwordField.placeholder = @"密码";
    _passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    //设置成密码样式
    _passwordField.secureTextEntry = YES;
    
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [[FAKIonIcons lockedIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];//[UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.leftView = passwordIconContainer;
    
    _loginButton = [FUIButton new];// initWithFrame:CGRectMake(25, 336, 263, 62)];
    //取消点击效果 NO;
    _loginButton.adjustsImageWhenHighlighted = YES;
    _loginButton.frame = CGRectMake(25, 336, 263, 62);
    _loginButton.backgroundColor = darkColor;
    _loginButton.layer.cornerRadius = 3.0f;
    _loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    _forgotButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 382, 263, 62)];
    _forgotButton.backgroundColor = [UIColor clearColor];
    _forgotButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    [_forgotButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotButton setTitleColor:darkColor forState:UIControlStateNormal];
    [_forgotButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 400, 263, 62)];
    _registerButton.backgroundColor = [UIColor clearColor];
    _registerButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    [_registerButton setTitle:@"去注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:darkColor forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 39, 275, 120)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor =  [UIColor whiteColor];
    _titleLabel.font =  [UIFont fontWithName:boldFontName size:16.0f];
    _titleLabel.text = @"A runner must run with dreams in his heart. —Emil Zatopek";
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 1200, 257, 25)];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.backgroundColor = [UIColor clearColor];
    _subTitleLabel.textColor =  [UIColor whiteColor];
    _subTitleLabel.font =  [UIFont fontWithName:fontName size:12.0f];
    
    _subTitleLabel.text = @"跑者必须心中带着梦想跑步";
    
    _weiboButton = [FUIButton new];// initWithFrame:CGRectMake(25, 336, 263, 62)];
    _weiboButton.frame = CGRectMake(50, 450, 50, 50);
    _weiboButton.backgroundColor = [UIColor clearColor];
    _weiboButton.layer.cornerRadius = 10.0f;
    _weiboButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_weiboButton setTitle:@"" forState:UIControlStateNormal];
    [_weiboButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_weiboButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [_weiboButton setImage:[UIImage imageNamed:@"UMS_sina_icon.png"] forState:UIControlStateNormal];
    
    _wxButton = [FUIButton new];// initWithFrame:CGRectMake(25, 336, 263, 62)];
    _wxButton.frame = CGRectMake(130, 450, 50, 50);
    _wxButton.backgroundColor = [UIColor clearColor];
    _wxButton.layer.cornerRadius = 10.0f;
    _wxButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_wxButton setTitle:@"" forState:UIControlStateNormal];
    [_wxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_wxButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [_wxButton setImage:[UIImage imageNamed:@"UMS_wechat_icon.png"] forState:UIControlStateNormal];
    
    _qqButton = [FUIButton new];// initWithFrame:CGRectMake(25, 336, 263, 62)];
    _qqButton.frame = CGRectMake(210, 450, 50, 50);
    _qqButton.backgroundColor = [UIColor clearColor];
    _qqButton.layer.cornerRadius = 10.0f;
    _qqButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_qqButton setTitle:@"" forState:UIControlStateNormal];
    [_qqButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_qqButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [_qqButton setImage:[UIImage imageNamed:@"UMS_qq_icon.png"] forState:UIControlStateNormal];
}
@end
