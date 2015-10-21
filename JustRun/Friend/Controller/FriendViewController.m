//
//  FriendViewController.h
//  JustRun
//
//  Created by liyongjie on 9/19/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "FriendViewController.h"
#import "UserCell.h"
#import "UIColor+Util.h"
#import "User.h"

static NSString * const USER_CELL_ID = @"UserCell";

@interface FriendViewController ()
@property (nonatomic, copy) NSMutableArray *datas;
//@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友";
    //self.view.backgroundColor = [UIColor greenColor];
    _datas = [NSMutableArray new];
    [self createDatas];
    //这行代码必须要 注册cell
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:USER_CELL_ID];
}

- (void)setupRefreshHeaderAndFooter {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshResult)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreResult)];
    header.automaticallyChangeAlpha = YES;
    footer.automaticallyRefresh = NO;
    self.tableView.header = header;
    self.tableView.footer = footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *friend = _datas[indexPath.row];
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_CELL_ID forIndexPath:indexPath];
    
    //    [cell.portrait loadPortrait:friend.portraitURL];
    cell.nameLabel.text = friend.username;
    cell.infoLabel.text = friend.mySignature;
    cell.infoLabel.textColor = [UIColor brownColor];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    OSCUser *friend = self.objects[indexPath.row];
//    self.label.text = friend.name;
//    self.label.font = [UIFont systemFontOfSize:16];
//    CGSize nameSize = [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)];
//
//    self.label.text = friend.expertise;
//    self.label.font = [UIFont systemFontOfSize:12];
//    CGSize infoLabelSize = [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)];
//
//    return nameSize.height + infoLabelSize.height + 21;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    } else {
        return 40;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.separatorColor = [UIColor separatorColor];
    
    return _datas.count;
}

- (void)createDatas{
    for (NSInteger i = 0; i < 100; i++) {
        User *user = [User new];
        //拼字符串
        user.username = [@"Test" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)i]];
        user.userID = i;
        user.location = @"广州";
        user.fansCount = [NSNumber numberWithInt:i];
        user.gender = @"男";
        user.mySignature = @"我的地盘我作主";
        [_datas addObject:user];
    }
}

@end
