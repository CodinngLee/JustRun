//
//  LoginViewController.m
//  JustRun
//
//  Created by liyongjie on 9/28/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ValidatorUtil.h"
#import "LoginView.h"
#import "CommonUtil.h"

#define kXHOFFSET_FOR_KEYBOARD 80.0

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup title
    
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    }
    self.title = @"登陆";
    self.view = [[LoginView alloc] initWithFrame:self.view.bounds];
    [self setUpEvent];
}

- (void)setUpEvent {
    LoginView *lv = (LoginView *)self.view;
//    __block BOOL isValidated = FALSE;
    __weak typeof (self) weakSelf = self;
    
    [lv.loginButton bk_addEventHandler:^(id sender) {
        NSString *username = lv.usernameField.text;
        NSString *password = lv.passwordField.text;
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
        
        if (isValidated) {
            [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
                if (![user isAuthenticated]) {
                    MBProgressHUD *HUD = [CommonUtil createHUD];
                    HUD.mode = MBProgressHUDModeText;
                    if ([ValidatorUtil isValidateEmail:username]) {
                        HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"用户邮箱未验证"];
                    } else if ([ValidatorUtil isValidatePhone:username]) {
                        HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"用户手机未验证"];
                    }
                    
                    [HUD hide:YES afterDelay:1];
                    return ;
                }
                if (user != nil) {
                    AVUser *currentUser = [AVUser currentUser];
                    if (currentUser != nil) {
                        // 允许用户使用应用
//                        NSLog(@"%@", [self.navigationController popViewControllerAnimated:YES]);
//                        NSLog(@"%@", [self.navigationController topViewController]);
//                        NSLog(@"%@", [self.navigationController presentedViewController]);
//                        NSLog(@"%@", [self.navigationController presentingViewController]);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        UITableViewController *vc = (UITableViewController *)[weakSelf.navigationController topViewController];
                        [vc.tableView reloadData];
                    } else {
                        //缓存用户对象为空时，可打开用户注册界面…
                    }
                } else {
                    MBProgressHUD *HUD = [CommonUtil createHUD];
                    HUD.mode = MBProgressHUDModeText;
                    HUD.detailsLabelText = [NSString stringWithFormat:@"%@", @"账号或密码输入错误，请重新输入"];
                    [HUD hide:YES afterDelay:1];
                }
            }];
        }
    } forControlEvents:UIControlEventTouchDown];
    
    [lv.forgotButton bk_addEventHandler:^(id sender) {
        JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"重设密码", @"手机验证码登陆"] buttonStyle:JGActionSheetButtonStyleDefault];
        JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
        
        NSArray *sections = @[section1, cancelSection];
        
        JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
        
        [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    
                } else if (indexPath.row == 1) {
                    
                }
            } else if (indexPath.section == 1) {
                [sheet dismissAnimated:YES];
            }
            
        }];
        
        [sheet showInView:weakSelf.view animated:YES];
    } forControlEvents:UIControlEventTouchDown];
    
    [lv.weiboButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchDown];
    
    [lv.wxButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchDown];
    
    [lv.qqButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchDown];
    
    [lv.registerButton bk_addEventHandler:^(id sender) {
        RegisterViewController *vc = [[RegisterViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchDown];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - keyboard helper

- (void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kXHOFFSET_FOR_KEYBOARD;
        rect.size.height += kXHOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kXHOFFSET_FOR_KEYBOARD;
        rect.size.height -= kXHOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
@end
