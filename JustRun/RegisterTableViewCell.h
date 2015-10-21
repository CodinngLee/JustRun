//
//  RegisterTableViewCell.h
//  JustRun
//
//  Created by liyongjie on 9/29/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_Register_Cell @"Register_Cell"
@interface RegisterTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString*);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString*);

- (void)editDidBegin:(id)sender;
- (void)editDidEnd:(id)sender;
- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr;
- (void)textValueChanged:(id)sender;
- (void)clearBtnClicked:(id)sender;

@end
