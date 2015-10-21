//
//  MyViewController.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "MyViewController.h"
#import "SettingsViewController.h"
#import "MyInfoCell.h"
#import "ActionSheetPicker.h"
#import "UserPreferences.h"
#import "LoginViewController.h"
#import "MWPhotoBrowser.h"
#import "RSKImageCropViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>//包含调用相机设备时要传的参数

static NSString * const MYINFO_CELL_ID = @"MyInfo_Cell";
#define ORIGINAL_MAX_WIDTH 640.0f

@interface MyViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate /*RSKImageCropViewControllerDataSource*/>
{
    NSMutableArray *_section1DataSourceArray;
    NSMutableArray *_section2DataSourceArray;
    NSMutableArray *_section3DataSourceArray;
    NSMutableArray *_heights;
    NSMutableArray *_runOfAges;
    NSMutableArray *_ages;
    NSMutableArray *_waistlines;
    NSMutableArray *_weights;
    NSInteger      selectedIndex;
    UIImage        *image;
}
@end


@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // setup title
    self.title = @"我的";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initViews];
    [self initHeights];
    [self initRunOfAges];
    [self initAges];
    [self initWeights];
    [self initWaistlines];
    //这行代码必须要 注册cell
    [self.tableView registerClass:[MyInfoCell class] forCellReuseIdentifier:MYINFO_CELL_ID];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)initHeights {
    _heights = [[NSMutableArray alloc] init];
    for (NSInteger i = 100; i < 210; i++) {
        [_heights addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)initRunOfAges {
    _runOfAges = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 20; i++) {
        [_runOfAges addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)initAges {
    _ages = [[NSMutableArray alloc] init];
    for (NSInteger i = 12; i < 80; i++) {
        [_ages addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)initWeights {
    _weights = [[NSMutableArray alloc] init];
    for (NSInteger i = 40; i < 90; i++) {
        [_weights addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)initWaistlines {
    _waistlines = [[NSMutableArray alloc] init];
    for (NSInteger i = 40; i < 120; i++) {
        [_waistlines addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _section1DataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"年龄" forKey:@"title"];
    [dic1 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic1 setObject:[NSString stringWithFormat:@"%ld", [UserPreferences age]] forKey:@"value"];
    [_section1DataSourceArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"地区" forKey:@"title"];
    [dic2 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic2 setObject:[UserPreferences area] forKey:@"value"];
    [_section1DataSourceArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"简介" forKey:@"title"];
    [dic3 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic3 setObject:[UserPreferences myWord] forKey:@"value"];
    [_section1DataSourceArray addObject:dic3];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"跑龄" forKey:@"title"];
    [dic4 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic4 setObject:[NSString stringWithFormat:@"%ld", [UserPreferences runOfAge]] forKey:@"value"];
    [_section1DataSourceArray addObject:dic4];

    _section2DataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:@"身高" forKey:@"title"];
    [dic5 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic5 setObject:[NSString stringWithFormat:@"%ld", [UserPreferences height]] forKey:@"value"];
    [_section2DataSourceArray addObject:dic5];
    
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc] init];
    [dic6 setObject:@"体重" forKey:@"title"];
    [dic6 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic6 setObject:[NSString stringWithFormat:@"%ld", [UserPreferences weight]] forKey:@"value"];
    [_section2DataSourceArray addObject:dic6];
    
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc] init];
    [dic7 setObject:@"腰围" forKey:@"title"];
    [dic7 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic7 setObject:[NSString stringWithFormat:@"%ld", [UserPreferences waistline]] forKey:@"value"];
    [_section2DataSourceArray addObject:dic7];
    
    _section3DataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc] init];
    [dic8 setObject:@"设置" forKey:@"title"];
    [dic8 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic8 setObject:@"" forKey:@"value"];
    [_section3DataSourceArray addObject:dic8];
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        return 1;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _section1DataSourceArray.count;
    } else if (section == 2) {
        return _section2DataSourceArray.count;
    } else {
        return _section3DataSourceArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 75;
    } else if (section == 1) {
        return 5;
    } else if (section == 2) {
        return 5;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        //        headerView.backgroundColor = [UIColor greenColor];
        headerView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_login"]];
        //头像
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
        userImage.tag = 2000;
        userImage.layer.masksToBounds = YES;
        userImage.layer.cornerRadius = 27;
        
        [headerView addSubview:userImage];
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 15, 200, 30)];
        userNameLabel.font = [UIFont systemFontOfSize:13];
        AVUser *currentUser = [AVUser currentUser];
        if (currentUser == nil) {
            userNameLabel.text = @"未登陆";
            [userImage setImage:[UIImage imageNamed:@"default－portrait.png"]];
        } else {
            userNameLabel.text = currentUser.username;
            AVFile *portraitFile = [currentUser objectForKey:@"portrait"];
            NSData *portraitFileData = [portraitFile getData];
            if (portraitFileData == nil) {
                [userImage setImage:[UIImage imageNamed:@"default－portrait.png"]];
            } else {
                [userImage setImage:[UIImage imageWithData:portraitFileData]];
            }
        }
        
        [headerView addSubview:userNameLabel];
        
        //粉丝
        UILabel *followerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 40, 200, 30)];
        followerLabel.font = [UIFont systemFontOfSize:13];
        NSString *followerStr = @"粉丝：";
        followerLabel.text = [followerStr stringByAppendingFormat:@"%ld", [UserPreferences fansCount]];
        [headerView addSubview:followerLabel];
        
        //关注
        UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5+50, 40, 200, 30)];
        followLabel.font = [UIFont systemFontOfSize:13];
        NSString *followStr = @"关注：";
        
        followLabel.text = [followStr stringByAppendingFormat:@"%ld", [UserPreferences followCount]];
        [headerView addSubview:followLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 24, 30, 12, 24)];
        [arrowImg setImage:[UIImage imageNamed:@"icon_mine_accountViewRightArrow"]];
        [headerView addSubview: arrowImg];
        
        __weak typeof (self) weakSelf = self;
        //必须加上这句，否则不起作用
        userImage.userInteractionEnabled = YES;
        [userImage bk_whenTapped:^{
            AVUser *currentUser = [AVUser currentUser];
            if (currentUser == nil) {
                LoginViewController *lvc = [[LoginViewController alloc] init];
                [lvc setHidesBottomBarWhenPushed:YES];
                [weakSelf.navigationController pushViewController:lvc animated:TRUE];
            } else {
                //从手机中选择
                UIImagePickerController *imagePickerController = [UIImagePickerController new];
                imagePickerController.delegate = self;
                //图片库模式
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.allowsEditing = YES;
                imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }];

        return headerView;
    }

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MYINFO_CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MYINFO_CELL_ID];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [_section1DataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_section1DataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.infoValLabel.text = [_section1DataSourceArray[indexPath.row] objectForKey:@"value"];
        
    } else if (indexPath.section == 2) {
        cell.textLabel.text = [_section2DataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_section2DataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.infoValLabel.text = [_section2DataSourceArray[indexPath.row] objectForKey:@"value"];
//        cell.textLabel.text = @"设置";
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 3) {
        cell.textLabel.text = [_section3DataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_section3DataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //防止点击cell后留下选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MYINFO_CELL_ID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MYINFO_CELL_ID];
    }
    UILabel *sender = cell.infoValLabel;
    
    if (section == 1) {
        if (row == 0) {
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //[_section2DataSourceArray[indexPath.row] objectForKey:@"value"] = selectedValue;
                [_section1DataSourceArray[indexPath.row] setObject:selectedValue forKey:@"value"];
                sender.text = selectedValue;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [UserPreferences setAge:[selectedValue integerValue]];
                AVUser *currentUser = [AVUser currentUser];
                [currentUser setObject:[NSNumber numberWithInteger:[selectedValue integerValue]] forKey:@"age"];
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [currentUser saveEventually];
                }];
            };
            
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
                
            };
            NSInteger curIndex = [_ages indexOfObject:[NSString stringWithFormat:@"%ld", [UserPreferences age]]];
            [ActionSheetStringPicker showPickerWithTitle:@"选择年龄" rows:_ages initialSelection:curIndex doneBlock:done cancelBlock:cancel origin:sender];
        } else if (row == 1) {
        } else if (row == 2) {
        } else if (row == 3) {
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //[_section2DataSourceArray[indexPath.row] objectForKey:@"value"] = selectedValue;
                [_section1DataSourceArray[indexPath.row] setObject:selectedValue forKey:@"value"];
                sender.text = selectedValue;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [UserPreferences setRunOfAge:[selectedValue integerValue]];
                AVUser *currentUser = [AVUser currentUser];
                [currentUser setObject:[NSNumber numberWithInteger:[selectedValue integerValue]] forKey:@"runOfAge"];
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [currentUser saveEventually];
                }];
            };
            
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
                
            };
            NSInteger curIndex = [_runOfAges indexOfObject:[NSString stringWithFormat:@"%ld", [UserPreferences runOfAge]]];
            [ActionSheetStringPicker showPickerWithTitle:@"选择跑龄" rows:_runOfAges initialSelection:curIndex doneBlock:done cancelBlock:cancel origin:sender];
        }
    } else if (section == 2) {
        if (row == 0) {
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //[_section2DataSourceArray[indexPath.row] objectForKey:@"value"] = selectedValue;
                [_section2DataSourceArray[indexPath.row] setObject:selectedValue forKey:@"value"];
                sender.text = selectedValue;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [UserPreferences setHeight:[selectedValue integerValue]];
                AVUser *currentUser = [AVUser currentUser];
                [currentUser setObject:[NSNumber numberWithInteger:[selectedValue integerValue]] forKey:@"height"];
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [currentUser saveEventually];
                }];
            };
            
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
                
            };
            NSInteger curIndex = [_heights indexOfObject:[NSString stringWithFormat:@"%ld", [UserPreferences height]]];
            [ActionSheetStringPicker showPickerWithTitle:@"选择身高" rows:_heights initialSelection:curIndex doneBlock:done cancelBlock:cancel origin:sender];
        } else if (row == 1) {
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //[_section2DataSourceArray[indexPath.row] objectForKey:@"value"] = selectedValue;
                [_section2DataSourceArray[indexPath.row] setObject:selectedValue forKey:@"value"];
                sender.text = selectedValue;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [UserPreferences setWeight:[selectedValue integerValue]];
                AVUser *currentUser = [AVUser currentUser];
                [currentUser setObject:[NSNumber numberWithInteger:[selectedValue integerValue]] forKey:@"weight"];
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [currentUser saveEventually];
                }];
            };
            
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
                
            };
            NSInteger curIndex = [_weights indexOfObject:[NSString stringWithFormat:@"%ld", [UserPreferences weight]]];
            [ActionSheetStringPicker showPickerWithTitle:@"选择体重" rows:_weights initialSelection:curIndex doneBlock:done cancelBlock:cancel origin:sender];
        } else if (row == 2) {
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //[_section2DataSourceArray[indexPath.row] objectForKey:@"value"] = selectedValue;
                [_section2DataSourceArray[indexPath.row] setObject:selectedValue forKey:@"value"];
                sender.text = selectedValue;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                //id转NSInteger
                [UserPreferences setWaistline:[selectedValue integerValue]];
                //云端保存个人资料中腰围数据
                AVUser *currentUser = [AVUser currentUser];
                [currentUser setObject:[NSNumber numberWithInteger:[selectedValue integerValue]] forKey:@"waistline"];
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [currentUser saveEventually];
                }];
            };
            
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
                
            };
            NSInteger curIndex = [_waistlines indexOfObject:[NSString stringWithFormat:@"%ld", [UserPreferences waistline]]];
            [ActionSheetStringPicker showPickerWithTitle:@"选择腰围" rows:_waistlines initialSelection:curIndex doneBlock:done cancelBlock:cancel origin:sender];
        }
        
    } else if (section == 3) {
        viewController = [[SettingsViewController alloc] init];
    }
    if (viewController) {
        //push的viewController隐藏Tabbar
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    //消除cell选择痕迹
    //[self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

//- (void)deselect
//{
//    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//}

//选择图片库后事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageCropVC animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    UIImageView *userImage = (UIImageView *)[self.tableView viewWithTag:2000];
    userImage.image = croppedImage;
    //异步上传图片
    NSData *imageData = UIImagePNGRepresentation(croppedImage) ? nil : UIImageJPEGRepresentation(croppedImage, 1.0);
    AVFile *portraitFile = [AVFile fileWithName:@"portrait" data:imageData];
    [portraitFile saveInBackground];
    AVUser *user = [AVUser currentUser];
    [user setObject:portraitFile forKey:@"portrait"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [user saveEventually];
    }];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle
{
    UIImageView *userImage = (UIImageView *)[self.tableView viewWithTag:2000];
    userImage.image = croppedImage;
    //异步上传图片
    NSData *imageData = UIImagePNGRepresentation(croppedImage);
    AVFile *portraitFile = [AVFile fileWithName:@"portrait" data:imageData];
//    [portraitFile saveInBackground];
    AVUser *user = [AVUser currentUser];
    [user setObject:portraitFile forKey:@"portrait"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [user saveEventually];
    }];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image will be cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                  willCropImage:(UIImage *)originalImage
{
    // Use when `applyMaskToCroppedImage` set to YES.

}
@end