//
//  RegisterViewController.m
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "ValidatorUtil.h"
#import "CommonUtil.h"
#import "RegisterView.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    self.view = [[RegisterView alloc] initWithFrame:self.view.bounds];
    [self setUpEvent];
}

- (void)setUpEvent {
    RegisterView *v = (RegisterView *)self.view;

    
    [v.registerButton bk_addEventHandler:^(id sender) {
        NSString *username = v.usernameField.text;
        NSString *password = v.passwordField.text;
        NSString *configrmPassword = v.confirmPasswordField.text;
        __block BOOL isValidated = TRUE;
        if ([username length] == 0) {
            MBProgressHUD *HUD = [CommonUtil createHUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"账号不能为空"];
            [HUD hide:YES afterDelay:1];
            isValidated = FALSE;
            return ;
        }
        if ([password length] == 0) {
            MBProgressHUD *HUD = [CommonUtil createHUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"密码不能为空"];
            [HUD hide:YES afterDelay:1];
            isValidated = FALSE;
            return ;
        }
        
        if (![password isEqualToString:configrmPassword]) {
            MBProgressHUD *HUD = [CommonUtil createHUD];
            HUD.mode = MBProgressHUDModeText;
            HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"两次输入密码不一致，请重新输入"];
            [HUD hide:YES afterDelay:1];
            isValidated = FALSE;
            return ;
        }
        
        if (isValidated) {
            AVUser *user = [AVUser user];
            user.username = username;
            user.password = password;
            user.email = username;
            if ([ValidatorUtil isValidateEmail:username]) {
                [user setObject:username forKey:@"email"];
            } else if ([ValidatorUtil isValidatePhone:username]) {
                [user setObject:username forKey:@"mobilePhoneNumber"];
            }
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    MBProgressHUD *HUD = [CommonUtil createHUD];
                    HUD.mode = MBProgressHUDModeText;
                    HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"注册成功,请到邮箱验证"];
                    [HUD hide:YES afterDelay:1];
                    
                } else {
                    MBProgressHUD *HUD = [CommonUtil createHUD];
                    HUD.mode = MBProgressHUDModeText;
                    HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"注册失败，服务器异常"];
                    [HUD hide:YES afterDelay:1];
                }
            }];
        }
    } forControlEvents:UIControlEventTouchDown];
}
@end