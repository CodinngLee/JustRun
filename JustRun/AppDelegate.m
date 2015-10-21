//
//  AppDelegate.m
//  JustRun
//
//  Created by liyongjie on 9/16/15.
//  Copyright (c) 2015 net.oeilbleu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "MyViewController.h"
#import "ChartViewController.h"
#import "FriendViewController.h"
#import "CASUtilities.h"
#import "CASStyler.h"
#import "Harpy.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"
#import "CommonUtil.h"
#import "UserPreferences.h"
#import "UIImageView+WebCache.h"

// App Colors
#define THEME_COLOR UIColorFromRGB(0x3E86E4)
#define BACKGROUND_COLOR UIColorFromRGB(0xF0EFF4)
#define CELL_BORDER_COLOR UIColorFromRGB(0xE8E7E8)

static NSString *const APP_ID = @"123456";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self applicationLogerInit];
#if TARGET_IPHONE_SIMULATOR
    NSString *absoluteFilePath = CASAbsoluteFilePath(@"stylesheet.cas");
    [CASStyler defaultStyler].watchFilePath = absoluteFilePath;
#endif
    //3D touch设置
    [self setupShortcutItem];
    
    [self leancloudInit:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if ([UserPreferences isFirstLaunch]) {
        self.window.rootViewController = [self setupIntroViewController];
    } else {
        self.window.rootViewController = [self rootViewController];
    }
    
    [self setupAFNetwork];
    
    [self setupSDWebImage];

    [self setupMagicalRecord];
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self navigationBarInit];
    
    [self initHarpy];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupAFNetwork {
    //网络
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setupMagicalRecord {
    //设置数据库名字
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"JustRun.sqlite"];
}

- (void)setupSDWebImage {
    //sd加载的数据类型
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
}

- (void)leancloudInit:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:LEANCOUND_API_ID
                      clientKey:LEANCOUND_API_KEY];
    
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

- (void)navigationBarInit {
    // customize navigation bar 只对第一页的bar起作用
    [UINavigationBar appearance].barTintColor = THEME_COLOR;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:20] };
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Perform check for new version of your app
     Useful if user returns to you app from background after being sent tot he App Store,
     but doesn't update their app before coming back to your app.
     
     ONLY USE THIS IF YOU ARE USING *HarpyAlertTypeForce*
     
     Also, performs version check on first launch.
     */
    if ([CommonUtil networkStatus]) {
        [[Harpy sharedInstance] checkVersion];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([CommonUtil networkStatus]) {
        //每天检查更新
        [[Harpy sharedInstance] checkVersionDaily];
        
        //每周检查更新
    //    [[Harpy sharedInstance] checkVersionWeekly];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

- (void)applicationLogerInit {
    // Override point for customization after application launch.
    //DDASLLogger 将 log 发送给苹果服务器，之后在 Console.app 中可以查看
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    //DDTTYLogger 将 log 发送给 Xcode 的控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //DDFileLogger 将 log 写入本地文件
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //设置CocoaLumberjack颜色显示
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    //修改日志输出的颜色代码
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagDebug];
        DDLogError(@"日志颜色测试：Error红色");
    DDLogWarn(@"日志颜色测试：Warn橙色");
    DDLogInfo(@"日志颜色测试：Info黑色");
    DDLogVerbose(@"日志颜色测试：Verbose黑色");
}

- (UITabBarController *)rootViewController
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    FriendViewController *friendViewController = [[FriendViewController alloc] init];
    ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    ChartViewController *chartViewController = [[ChartViewController alloc] init];
    MyViewController *myViewController = [[MyViewController alloc] init];
    
    NSArray *subControllers = @[ activityViewController, friendViewController, homeViewController, chartViewController, myViewController ];
    NSMutableArray *tabSubControllers = [[NSMutableArray alloc] init];
    
    NSArray *titles = @[ @"活动", @"朋友", @"主页", @"图表", @"我的" ];
    NSArray *fontAwesomeImages = @[
        [FAKIonIcons iosListIconWithSize:30],
        [FAKIonIcons iosPeopleIconWithSize:30],
        [FAKIonIcons homeIconWithSize:30],
        [FAKIonIcons podiumIconWithSize:30],
        [FAKIonIcons personIconWithSize:30]
    ];
    
    [subControllers enumerateObjectsUsingBlock:^(UIViewController *controller, NSUInteger idx, BOOL* stop) {
        controller.tabBarItem.title = titles[idx];
        controller.tabBarItem.image = [fontAwesomeImages[idx] imageWithSize:CGSizeMake(30, 30)];
//        controller.tabBarItem.selectedImage = [UIImage imageNamed:tabSelectedImageNames[idx]];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [tabSubControllers addObject:navigationController];
        navigationController.navigationBar.barTintColor = THEME_COLOR;
        navigationController.navigationBar.translucent = NO;
        navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:20] };
    }];
    tabBarController.viewControllers = tabSubControllers;
    tabBarController.selectedIndex = 2;
    return tabBarController;
}

- (void) initHarpy {
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:APP_ID];
    
    // Set the UIViewController that will present an instance of UIAlertController
    [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];
    
    // (Optional) The tintColor for the alertController
    [[Harpy sharedInstance] setAlertControllerTintColor:@"<#alert_controller_tint_color#>"];
    
    // (Optional) Set the App Name for your app
    [[Harpy sharedInstance] setAppName:@"JustRun"];
    
    /* (Optional) Set the Alert Type for your app
     By default, Harpy is configured to use HarpyAlertTypeOption */
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    
    /* (Optional) If your application is not availabe in the U.S. App Store, you must specify the two-letter
     country code for the region in which your applicaiton is available. */
    [[Harpy sharedInstance] setCountryCode:@"zh_CN"];
    
    /* (Optional) Overides system language to predefined language.
     Please use the HarpyLanguage constants defined in Harpy.h. */
    [[Harpy sharedInstance] setForceLanguageLocalization:@"zh_CN"];
    
    if ([CommonUtil networkStatus]) {
        // Perform check for new version of your app
        DDLogDebug(@"检查版本更新");
        [[Harpy sharedInstance] checkVersion];
    }

}

- (OnboardingViewController *)setupIntroViewController {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"What A Beautiful Photo" body:@"This city background image is so beautiful." image:[UIImage imageNamed:@"title1"] buttonText:@"Enable Location Services" action:^{
    }];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"I'm so sorry" body:@"I can't get over the nice blurry background photo." image:[UIImage imageNamed:@"title2"] buttonText:@"Connect With Facebook" action:^{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Prompt users to do other cool things on startup. As you can see, hitting the action button on the prior page brought you automatically to the next page. Cool, huh?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    secondPage.movesToNextViewController = YES;

    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Seriously Though" body:@"Kudos to the photographer." image:[UIImage imageNamed:@"title3"] buttonText:@"Get Started" action:^{
        [self handleOnboardingCompletion];
    }];
    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"runner"] contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    onboardingVC.fadeSkipButtonOnLastPage = YES;
    
    // If you want to allow skipping the onboarding process, enable skipping and set a block to be executed
    // when the user hits the skip button.
    onboardingVC.allowSkipping = YES;
    onboardingVC.skipHandler = ^{
        [self handleOnboardingCompletion];
    };
    
    return onboardingVC;
}

- (void)handleOnboardingCompletion {
    // set that we have completed onboarding so we only do it once... for demo
    // purposes we don't want to have to set this every time so I'll just leave
    // this here...
    [UserPreferences disableFirstLaunch];
    // transition to the main application
    self.window.rootViewController = [self rootViewController];
}

- (void)setupShortcutItem {
    UIApplicationShortcutItem *startRunShortItem = [[UIApplicationShortcutItem alloc] initWithType:@"startRun" localizedTitle:@"开始跑步"];
    UIApplicationShortcutItem *runActivityShortItem = [[UIApplicationShortcutItem alloc] initWithType:@"runActivity" localizedTitle:@"跑步记录"];
    NSArray *shortItems = [[NSArray alloc] initWithObjects:startRunShortItem, runActivityShortItem, nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqual: @"startRun"]) {
        UITabBarController *tabVc = (UITabBarController *)self.window.rootViewController;
        [tabVc setSelectedIndex:2];
        
        return;
    } else if ([shortcutItem.type isEqual: @"runActivity"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OPPS!" message:@"run activity" delegate:self cancelButtonTitle:@"哦" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}
@end