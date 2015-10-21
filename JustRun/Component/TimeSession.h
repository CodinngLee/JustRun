//
//  TimeSession.h
//  JustRun
//
//  Created by liyongjie on 10/9/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kSessionStateStart = 0,
    kSessionStateStop = 1
} SessionState;

@interface TimeSession : NSObject

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *finishDate;
@property (nonatomic, readonly) NSTimeInterval progressTime;
@property (nonatomic) NSTimeInterval realSeconds;
@property (nonatomic) SessionState state;
@end
