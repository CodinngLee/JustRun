//
//  RegisterView.h
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *confirmPasswordField;
@property (nonatomic, strong) FUIButton *registerButton;
@property (nonatomic, strong) UIButton *goLoginButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@end
