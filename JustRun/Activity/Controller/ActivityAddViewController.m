//
//  ActivityAddViewController.m
//  JustRun
//
//  Created by liyongjie on 9/30/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "ActivityAddViewController.h"
#import "ActionSheetPicker.h"
#import "InfoKeyValueCell.h"
#import "UIColor+Util.h"
#import "Activity.h"
#import "CommonUtil.h"
#import "SportMathUtils.h"

static NSString * const INFO_KEYVALUE_CELL_ID = @"Info_KeyValue_Cell";

@interface ActivityAddViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_sectionDataSourceArray;
    FUIButton *_okBtn;
    NSArray *_paces;
    NSArray *_distances;
    NSArray *_durations;
    Activity *_activity;
}
@end

@implementation ActivityAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增跑步记录";
    // Do any additional setup after loading the view.
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    //这行代码必须要 注册cell
    [self.tableView registerClass:[InfoKeyValueCell class] forCellReuseIdentifier:INFO_KEYVALUE_CELL_ID];
    
    NSString *actionSheetDatasPlist = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ActionSheetDatas.plist"];
    NSMutableDictionary *actionSheetDatasDic = [NSMutableDictionary dictionaryWithContentsOfFile:actionSheetDatasPlist];
    
    NSArray *paceMinutes = [[actionSheetDatasDic objectForKey:@"Pace"] objectForKey:@"minute"];
    NSArray *paceSeconds = [[actionSheetDatasDic objectForKey:@"Pace"] objectForKey:@"seconds"];
    NSArray *paceUnits = [[actionSheetDatasDic objectForKey:@"Pace"] objectForKey:@"unit"];
    _paces = @[paceMinutes, paceSeconds, paceUnits];
    
    NSArray *durationHours = [[actionSheetDatasDic objectForKey:@"Duration"] objectForKey:@"hour"];
    NSArray *durationMinute = [[actionSheetDatasDic objectForKey:@"Duration"] objectForKey:@"minute"];
    NSArray *durationSeconds = [[actionSheetDatasDic objectForKey:@"Duration"] objectForKey:@"seconds"];
    _durations = @[durationHours, durationMinute, durationSeconds];
    
    NSArray *distanceMain = [[actionSheetDatasDic objectForKey:@"Distance"] objectForKey:@"main"];
    NSArray *distanceOther = [[actionSheetDatasDic objectForKey:@"Distance"] objectForKey:@"other"];
    NSArray *distanceUnit = [[actionSheetDatasDic objectForKey:@"Distance"] objectForKey:@"unit"];
    _distances = @[distanceMain, distanceOther, distanceUnit];
    
    _activity = [[Activity alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {

    NSString *dateAndTime = [CommonUtil formatterDate:[NSDate date] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _sectionDataSourceArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"日期" forKey:@"title"];
    [dic1 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic1 setObject:dateAndTime forKey:@"value"];
    
    [_sectionDataSourceArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"距离" forKey:@"title"];
    [dic2 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic2 setObject:@"10km" forKey:@"value"];
    [_sectionDataSourceArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"持续时间" forKey:@"title"];
    [dic3 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic3 setObject:@"1h" forKey:@"value"];
    [_sectionDataSourceArray addObject:dic3];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"速度" forKey:@"title"];
    [dic4 setObject:@"icon_mine_onsite" forKey:@"image"];
    [dic4 setObject:@"7'29" forKey:@"value"];
    [_sectionDataSourceArray addObject:dic4];
}

-(void)initViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [self customHeaderView];
    self.tableView.tableFooterView = [self customFooterView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoKeyValueCell *cell = [tableView dequeueReusableCellWithIdentifier:INFO_KEYVALUE_CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InfoKeyValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFO_KEYVALUE_CELL_ID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [_sectionDataSourceArray[indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [_sectionDataSourceArray[indexPath.row] objectForKey:@"image"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.infoValLabel.text = [_sectionDataSourceArray[indexPath.row] objectForKey:@"value"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //防止点击cell后留下选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    InfoKeyValueCell *cell = [tableView dequeueReusableCellWithIdentifier:INFO_KEYVALUE_CELL_ID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[InfoKeyValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFO_KEYVALUE_CELL_ID];
    }
    UILabel *sender = cell.infoValLabel;
    
    if (section == 0) {
        if (row == 0) {
//            ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select a time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:self.selectedTime target:self action:@selector(timeWasSelected:element:) origin:sender];
            [ActionSheetDatePicker showPickerWithTitle:@"设定时间" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date]  doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                
                NSString *dateAndTime = [CommonUtil formatterDate:selectedDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
                sender.text = dateAndTime;
                [_sectionDataSourceArray[indexPath.row] setObject:dateAndTime forKey:@"value"];
                _activity.activityDate = selectedDate;
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:^(ActionSheetDatePicker *picker) {
                ;
            } origin:sender];
        } else if (row == 1) {
            NSArray *indexs = @[@1, @1, @1];
            [ActionSheetMultipleStringPicker showPickerWithTitle:@"设定距离" rows:_distances initialSelection:indexs doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
                
                NSString *val = [@"" stringByAppendingFormat:@"%@%@%@", selectedValues[0], selectedValues[1], selectedValues[2]];
                sender.text = val;
                [_sectionDataSourceArray[indexPath.row] setObject:val forKey:@"value"];
                _activity.distance = [NSNumber numberWithFloat:[[@"" stringByAppendingFormat:@"%@%@", selectedValues[0], selectedValues[1]] floatValue]];
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                
            } origin:sender];
        } else if (row == 2) {
            NSArray *indexs = @[@1, @1, @1];
            [ActionSheetMultipleStringPicker showPickerWithTitle:@"设定持续时间" rows:_durations initialSelection:indexs doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
                NSString *val = [@"" stringByAppendingFormat:@"%@%@%@", selectedValues[0], selectedValues[1], selectedValues[2]];
                sender.text = [@"" stringByAppendingFormat:@"%@:%@:%@", selectedValues[0], selectedValues[1], selectedValues[2]];
                
                int intDuration = [[selectedValues[0] substringToIndex:1] intValue] * 60 * 60 + [[selectedValues[1] substringToIndex:1] intValue] * 60 +
                                         [[selectedValues[2] substringToIndex:1] intValue];
                _activity.duration = [NSNumber numberWithInt:intDuration];
                
                NSString *paceStr = [SportMathUtils stringifyAvgPaceFromDist:[_activity.distance floatValue] overTime:intDuration];
                
                NSString *unitName = @" min/km";
                NSRange range = [paceStr rangeOfString:unitName];
                paceStr = [paceStr substringToIndex:range.location];
                NSArray *paceStrArr = [paceStr componentsSeparatedByString:@":"];
                
//                //获取填写配速的cell
//                InfoKeyValueCell *paceCell = [tableView dequeueReusableCellWithIdentifier:INFO_KEYVALUE_CELL_ID forIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//                //更改cell的val
//                paceCell.infoValLabel.text = [@"" stringByAppendingFormat:@"%@'%@/公里", paceStrArr[0], paceStrArr[1]];
//                
                [_sectionDataSourceArray[indexPath.row] setObject:val forKey:@"value"];
                [_sectionDataSourceArray[indexPath.row + 1] setObject:[@"" stringByAppendingFormat:@"%@'%@/公里", paceStrArr[0], paceStrArr[1]]
 forKey:@"value"];
                
                int intPace = [paceStrArr[0] intValue] * 60 + [paceStrArr[1] intValue];
                _activity.pace = [NSNumber numberWithInt:intPace];
                
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                
            } origin:sender];
        } else if (row == 3) {
            NSArray *indexs = @[@2, @4, @1];
            [ActionSheetMultipleStringPicker showPickerWithTitle:@"设定配速" rows:_paces initialSelection:indexs doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
                NSString *val = [@"" stringByAppendingFormat:@"%@'%@%@", selectedValues[0], selectedValues[1], selectedValues[2]];
                sender.text = val;
                
                int intPace = [[selectedValues[0] substringToIndex:1] intValue] * 60 +
                [[selectedValues[1] substringToIndex:1] intValue];
                _activity.pace = [NSNumber numberWithInt:intPace];
                
                [_sectionDataSourceArray[indexPath.row] setObject:val forKey:@"value"];
                [cell setNeedsDisplay];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {

            } origin:sender];
        }
    }
}


#pragma mark - Table view Header Footer
- (UIView *)customHeaderView {
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.10 * SCREEN_HEIGHT)];
    headerV.backgroundColor = [UIColor clearColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    //设置字体
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    //文本颜色
    headerLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    //对齐方式
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"Save your Record";
    [headerLabel setCenter:headerV.center];
    [headerV addSubview:headerLabel];
    
    return headerV;
}

- (UIView *)customFooterView {
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _okBtn = [FUIButton new];
    _okBtn.frame = CGRectMake(20, 50, SCREEN_WIDTH - 20 * 2, 45);
    _okBtn.backgroundColor = [UIColor cloudsColor];
    [_okBtn setTitle:@"完成" forState:UIControlStateNormal];
    _okBtn.buttonColor = [UIColor turquoiseColor];
    _okBtn.shadowColor = [UIColor greenSeaColor];
    _okBtn.shadowHeight = 1.0f;
    _okBtn.cornerRadius = 4.0f;
    _okBtn.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [_okBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_okBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    __weak typeof (self) weakSelf = self;
    [_okBtn bk_addEventHandler:^(id sender) {
        //判断是否全部数据填写完
        
        //保存到本地
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
            Activity *act = [Activity MR_createEntityInContext:localContext];
            act.distance = _activity.distance;
            act.pace = _activity.pace;
            act.duration = _activity.duration;
            act.activityDate = _activity.activityDate;
        } completion:^(BOOL success, NSError *error) {
            if (!error) {
                [CommonUtil tip:@"添加记录成功"];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                UITableViewController *vc = (UITableViewController *)[weakSelf.navigationController topViewController];
                [vc.tableView reloadData];
                
                //如果有网络，并且已登陆，则保存到云端
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser != nil) {
                    AVObject *runActivity = [AVObject objectWithClassName:@"Activity"];
                    [runActivity setObject:_activity.pace forKey:@"Pace"];
                    [runActivity setObject:_activity.duration forKey:@"Duration"];
                    [runActivity setObject:_activity.distance forKey:@"Distance"];
                    NSDate *date = [NSDate date];
                    [runActivity setObject:date forKey:@"RecordTime"];
                    [runActivity setObject:[AVUser currentUser] forKey:@"CreatedBy"];
                    //跑步日期
                    [runActivity setObject:_activity.activityDate forKey:@"ActivityDate"];
                    [runActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        [runActivity saveEventually];
                    }];
                }
            } else {
                [CommonUtil tip:@"添加记录错误，请重新输入"];
            }
        }];


    } forControlEvents:UIControlEventTouchDown];
    [footerV addSubview:_okBtn];
    return footerV;
}
@end