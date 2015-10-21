//
//  SettingsViewController.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppConfigure.h"
#import "CommonUtil.h"

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *CellHasSwitchID = @"HasSwitchCell";
static NSString *CellHasDIID = @"HasDICell";
static NSString *CellHasSecondLabelID = @"HasSecondLabelCell";
static NSString *CellLogOutID = @"LogOutCell";

@implementation SettingsViewController {
	NSArray *sectionHeaderTexts;
	NSArray *dataSource;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//	self.view.backgroundColor = [UIColor whiteColor];
	// 设置夜间模式背景色
//	self.view.nightBackgroundColor = NightBGViewColor;
	
	[self setTitleView];
	[self setUpViews];
	
	sectionHeaderTexts = @[@"浏览设置", @"缓存设置", @"更多", @""];
	
	dataSource = @[@[@"夜间模式切换"],
				   @[@"清除缓存"],
				   @[@"去评分", @"反馈", @"用户协议", @"版本号", @"开源组件"],
				   @[@"退出当前账号"]];//@[@"自动上传数据"]
}

#pragma mark - Lifecycle

- (void)dealloc {
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	[self.tableView removeFromSuperview];
	self.tableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setTitleView {
	UILabel *titleLabel = [UILabel new];
	titleLabel.text = @"设置";
	titleLabel.textColor = TitleTextColor;
	titleLabel.nightTextColor = TitleTextColor;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
	[titleLabel sizeToFit];
	self.navigationItem.titleView = titleLabel;
}

- (void)setUpViews {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	// 不显示空 cell
	self.tableView.tableFooterView = [[UIView alloc] init];
	// 设置 cell 的行高，固定为 44
	self.tableView.rowHeight = 44;
	self.tableView.sectionFooterHeight = 0;
	self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasSwitchID];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasDIID];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasSecondLabelID];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellLogOutID];
	self.tableView.backgroundColor = DawnViewBGColor;
	self.tableView.nightBackgroundColor = NightBGViewColor;
	self.tableView.separatorColor = TableViewCellSeparatorDawnColor;
	self.tableView.nightSeparatorColor = [UIColor blackColor];
	[self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *rowsData = dataSource[section];
	return rowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellID;
	
	switch (indexPath.section) {
		case 0:
			cellID = CellHasSwitchID;
			break;
		case 1:
		case 2: {
			if (indexPath.row < 3) {
				cellID = CellHasDIID;
			} else {
				cellID = CellHasSecondLabelID;
			}
		}
			break;
		case 3:
			cellID = CellLogOutID;
			break;
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
	cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
	cell.textLabel.nightTextColor = NightCellTextColor;
	cell.textLabel.font = SystemFont(17);
	cell.textLabel.textAlignment = NSTextAlignmentLeft;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	if (indexPath.section == 0) {
		UISwitch *nightModeSwitch = [[UISwitch alloc] init];
		nightModeSwitch.on = [AppConfigure boolForKey:APP_THEME_NIGHT_MODE];
		[nightModeSwitch addTarget:self action:@selector(nightModeSwitch:) forControlEvents:UIControlEventValueChanged];
		cell.accessoryView = nightModeSwitch;
	} else if (indexPath.section == 2 && indexPath.row == 3) {
		UILabel *versionLabel = [UILabel new];
		NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
		versionLabel.text = version;
		versionLabel.textColor = [UIColor colorWithRed:135 / 255.0 green:135 / 255.0 blue:135 / 255.0 alpha:1];
		versionLabel.nightTextColor = NightTextColor;
		versionLabel.font = SystemFont(17);
		[versionLabel sizeToFit];
		cell.accessoryView = versionLabel;
	} else if (indexPath.section == 3) {// 退出当前账号
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	cell.backgroundColor = DawnCellBGColor;
	cell.nightBackgroundColor = NightCellBGColor;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
	headerView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(headerView.frame) - 40, CGRectGetHeight(headerView.frame))];
	headerLabel.text = sectionHeaderTexts[section];
	headerLabel.textColor = [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1];
	headerLabel.nightTextColor = NightCellHeaderTextColor;
	headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
	[headerView addSubview:headerLabel];
	headerView.nightBackgroundColor = NightBGViewColor;
	
	return headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 1) {
        
    } else if (section == 2) {
        
    } else if (section == 3) {
        if (row == 0) {
            [self logout];
        }
    }
}

#pragma mark - Touch Events

- (void)nightModeSwitch:(UISwitch *)modeSwitch {
	if (modeSwitch.isOn) {
		[self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:NightNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
		self.tableView.backgroundColor = NightBGViewColor;
		[DKNightVersionManager nightFalling];
		[AppConfigure setBool:YES forKey:APP_THEME_NIGHT_MODE];
	} else {
		[self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:DawnNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
		self.tableView.backgroundColor = DawnViewBGColor;
		[DKNightVersionManager dawnComing];
		// why 要设置两次 TableView 的背景色？因为我发现，在设置界面切换夜间模式到普通模式之后，TableView 的背景色会变黑掉
		// 很奇怪的问题，然后我在调用 dawnComing 方法之后再设置一遍 Tableview 的背景色就可以解决这个问题。。。
		self.tableView.backgroundColor = DawnViewBGColor;
		[AppConfigure setBool:NO forKey:APP_THEME_NIGHT_MODE];
	}
	
	[self.tableView reloadData];
}

#pragma mark - Private

- (UIImage *)imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0, 0, 1, 1);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
	[color setFill];
	UIRectFill(rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (void)logout {
    __weak typeof (self) weakSelf = self;
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"确定"] buttonStyle:JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    
    NSArray *sections = @[section1, cancelSection];
    
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                [AVUser logOut];
                [CommonUtil tip:@"已退出账号"];
                [sheet dismissAnimated:YES];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                UITableViewController *vc = (UITableViewController *)[weakSelf.navigationController topViewController];
                [vc.tableView reloadData];
            }
        } else if (indexPath.section == 1) {
            [sheet dismissAnimated:YES];
        }
        
    }];
    
    [sheet showInView:weakSelf.view animated:YES];
}
@end