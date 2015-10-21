//
//  UIImage+Util.m
//  JustRun
//
//  Created by liyongjie on 10/8/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

+ (UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+ (UIImage *)fillWhite:(UIImage *)sourceImage
{
    
    CGRect bounds = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
    
    [[UIColor blackColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClipToMask(context, bounds, [sourceImage CGImage]);
    
    CGContextFillRect(context, bounds);
    return sourceImage;
}
@end
