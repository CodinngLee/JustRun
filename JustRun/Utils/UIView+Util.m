//
//  UIView+Util.m
//  FitNote
//
//  Created by liyongjie on 7/17/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
