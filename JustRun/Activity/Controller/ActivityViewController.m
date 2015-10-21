//
//  ActivityViewController.m
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "Activity.h"
#import "UIColor+Util.h"
#import "ActivityAddViewController.h"
#import "CommonUtil.h"
#import "SportMathUtils.h"

static NSString * const ACTIVITY_CELL_ID = @"Activity_Cell";

@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>
@property (nonatomic, copy) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动";
    _datas = [NSMutableArray new];

    //这行代码必须要 注册cell
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL_ID];
    
    __weak typeof(self) weakSelf = self;
    //为导航栏添加右侧按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemAdd handler:^(id sender) {
        ActivityAddViewController *v = [[ActivityAddViewController alloc] init];
        [weakSelf.navigationController pushViewController:v animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setupRefreshHeaderAndFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadMoreData];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)setupRefreshHeaderAndFooter {
    __weak typeof (self) weakSelf = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    header.automaticallyChangeAlpha = YES;
    footer.automaticallyRefresh = NO;
    self.tableView.header = header;
    self.tableView.footer = footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Activity *activity = _datas[indexPath.row];
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL_ID forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.paceLabel.text = [SportMathUtils stringifyAvgPaceFromDist:[activity.distance floatValue] overTime:[activity.duration intValue]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f", [activity.distance doubleValue]];
    
    cell.activityDateLabel.text = [CommonUtil formatterDate:activity.activityDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    cell.durationLabel.text = [SportMathUtils stringifySecondCount:[activity.duration intValue]  usingLongFormat:NO];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.separatorColor = [UIColor separatorColor];
    
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)loadMoreData
{
    // 1.添加数据
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setFetchLimit:10];
    [request setFetchOffset:self.currentPage * 10];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    [request setEntity:description];
    self.currentPage++;
    NSArray *activitys = [Activity MR_executeFetchRequest:request];
    if (activitys.count > 0) {
        for (Activity *act in activitys) {
            [_datas addObject:act];
        }
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    } else {
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.footer noticeNoMoreData];
    }

    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
}


#pragma mark - SWTableViewDelegate

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {

}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        //删除数据
        NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
        Activity *activity = _datas[cellIndexPath.row];
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [activity MR_deleteEntityInContext:localContext];
        } completion:^(BOOL contextDidSave, NSError *error) {
            if (!error) {
                [CommonUtil tip:@"删除记录成功"];
            } else {
                [CommonUtil tip:@"删除记录失败"];
            }
        }];
        [_datas removeObjectAtIndex:cellIndexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end