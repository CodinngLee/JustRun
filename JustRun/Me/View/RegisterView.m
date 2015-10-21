//
//  RegisterView.m
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RegisterView.h"
#import "FAKIcon.h"
#import "FAKIonIcons.h"

@implementation RegisterView

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
    [self addSubview:self.goLoginButton];
    [self addSubview:self.registerButton];
    
    [self addSubview:self.usernameField];
    [self addSubview:self.passwordField];
    [self addSubview:self.confirmPasswordField];
    
}

- (void)defineLayout {
    
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    //    self.backgroundColor = mainColor;
    self.backgroundColor = [UIColor darkGrayColor];
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(25, 198, 263, 41)];
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
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(25, 247, 263, 41)];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.layer.cornerRadius = 3.0f;
    _passwordField.placeholder = @"密码";
    _passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    //设置成密码样式
    _passwordField.secureTextEntry = YES;
    
    _confirmPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(25, 296, 263, 41)];
    _confirmPasswordField.backgroundColor = [UIColor whiteColor];
    _confirmPasswordField.layer.cornerRadius = 3.0f;
    _confirmPasswordField.placeholder = @"验证密码";
    _confirmPasswordField.font = [UIFont fontWithName:fontName size:16.0f];
    //设置成密码样式
    _confirmPasswordField.secureTextEntry = YES;
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [[FAKIonIcons lockedIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];//[UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    UIImageView *confirmPasswordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    confirmPasswordIconImage.image = [[FAKIonIcons lockedIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    UIView *confirmPasswordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    confirmPasswordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [confirmPasswordIconContainer addSubview:confirmPasswordIconImage];
    
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.leftView = passwordIconContainer;
    
    _confirmPasswordField.leftViewMode = UITextFieldViewModeAlways;
    _confirmPasswordField.leftView = confirmPasswordIconContainer;
    
    _registerButton = [FUIButton new];// initWithFrame:CGRectMake(25, 336, 263, 62)];
    //取消点击效果 NO;
    _registerButton.adjustsImageWhenHighlighted = YES;
    _registerButton.frame = CGRectMake(25, 346, 263, 62);
    _registerButton.backgroundColor = darkColor;
    _registerButton.layer.cornerRadius = 3.0f;
    _registerButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    _goLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 400, 263, 62)];
    _goLoginButton.backgroundColor = [UIColor clearColor];
    _goLoginButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    [_goLoginButton setTitle:@"去登陆" forState:UIControlStateNormal];
    [_goLoginButton setTitleColor:darkColor forState:UIControlStateNormal];
    [_goLoginButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
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
}

@end
