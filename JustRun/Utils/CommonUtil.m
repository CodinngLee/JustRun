//
//  CommonUtil.m
//  OpenRaiden
//
//  Created by liyongjie on 9/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
static long long time_stamp = 0;
static long long time_stamp_now = 0;
static NSMutableArray *temp = NULL;
static NSNumber *random_n = NULL;
static NSLock *theLock = NULL;
static NSDateFormatter *dateFormatter = NULL;

+ (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    
    // If needed, here is how to get a representation in bytes, returned as a structure
    // typedef struct {
    //   UInt8 byte0;
    //   UInt8 byte1;
    //   ...
    //   UInt8 byte15;
    // } CFUUIDBytes;
    CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
    
    CFRelease(uuidObject);
    
    return uuidStr;
}

/* 不重复的Id生成器
 *  获取下一个Id
 */
+ (long long)next {
    
    if(theLock == NULL)
        theLock = [[NSLock alloc]init];
    
    if(temp == NULL)
        temp = [[NSMutableArray alloc]init];
    
    @synchronized(theLock){
        time_stamp_now = [[NSDate date] timeIntervalSince1970];
        if (time_stamp_now != time_stamp) {
            //清空缓存，更新时间戳
            [temp removeAllObjects];
            time_stamp = time_stamp_now;
        }

        //判断缓存中是否存在当前随机数
        while([temp containsObject:(random_n = [NSNumber numberWithLong:arc4random() % 8999 + 1000])])
            ;
        
        if ([temp containsObject:random_n]) {
            return -1;
        }
        
        [temp addObject:[NSNumber numberWithLong:[random_n longValue]]];
    }
    
    return (time_stamp * 10000) + [random_n longValue];
}

+ (NSArray *) getAllLanguages {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages"];
    return languages;
}

+ (NSString *) getGUIDPath {
    //NSDocumentDirectory代表正在查找Documents目录
    //NSUserDomainMask代表仅搜索应用程序沙盒，OSX中代表搜索HOME目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

+ (NSString *) getTemporaryDirectory {
    NSString *tempPath = NSTemporaryDirectory();
    return tempPath;
}

+ (NSInteger)networkStatus
{
    Reachability *reachability = [Reachability reachabilityWithHostName:@"itunes.apple.com"];
    return reachability.currentReachabilityStatus;
}

+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    return HUD;
}

+ (void)tip:(NSString *)tipStr {
    MBProgressHUD *HUD = [CommonUtil createHUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabelText = [NSString stringWithFormat:@"%@", tipStr];
    [HUD hide:YES afterDelay:1];
}

+ (NSString *)formatterDate:(NSDate *)date withFormat:(NSString *)format {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:format];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval shortDate:(BOOL)shortDate {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (shortDate) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)minutes];
    }
    else {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    }
}

+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type {
    
    CGImageRef imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
    
}

@end