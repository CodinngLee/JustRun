//
//  TimeSession.m
//  JustRun
//
//  Created by liyongjie on 10/9/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "TimeSession.h"

@implementation TimeSession

- (NSTimeInterval)progressTime {
    _realSeconds += 1;
    if (_finishDate) {
        return [_finishDate timeIntervalSinceDate:self.startDate];
    }
    else {
        return [[NSDate date] timeIntervalSinceDate:self.startDate];
    }
}

@end
