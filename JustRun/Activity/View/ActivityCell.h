//
//  ActivityCellTableViewCell.h
//  JustRun
//
//  Created by liyongjie on 9/21/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ActivityCell : SWTableViewCell

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *activityDateLabel;
@property (nonatomic, strong) UILabel *distanceUnitLabel;

@end
