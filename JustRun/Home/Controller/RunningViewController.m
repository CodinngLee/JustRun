//
//  RunningViewController.m
//  JustRun
//
//  Created by liyongjie on 9/22/15.
//  Copyright © 2015 net.oeilbleu. All rights reserved.
//

#import "RunningViewController.h"
#import "RunningView.h"
#import "CNPPopupController.h"
#import "SOMotionDetector.h"
#import "TimeSession.h"
#import "JZLocationConverter.h"
#import "CommonUtil.h"
#import "Activity.h"
#import "SportMathUtils.h"
#import "UserPreferences.h"
#import <MAMapKit/MAMapKit.h>
#import <INTULocationManager/INTULocationManager.h>

@interface RunningViewController () <MAMapViewDelegate, CLLocationManagerDelegate, CNPPopupControllerDelegate, SOMotionDetectorDelegate>
{
    MAMapView *_mapView;
    CLLocationManager *_locationManager;
    CNPPopupController *_popupController;
    CGFloat _localProgress;
    NSTimer *_timer;
    TimeSession *_timeSession;
//    double _totalDistance;
    double _totalCalories;
    double _pace;
    //记录所有轨迹
    NSMutableArray *_locations;
    BOOL _bPause;
    Activity *_activity;
    FBKVOController *_kvoController;
}
@property (nonatomic, assign) double currentSpeed;
@property (nonatomic, assign) double currentDuration;
@property (nonatomic, assign) double currentTotalDistance;
@property (nonatomic, assign) NSString *currentMotionType;
@end

@implementation RunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //影藏导航条，自己控制代码返回上层
    self.navigationController.navigationBarHidden = YES;
    //运动检测初始化
    [self initMotionDetector];
    [self mapViewInit];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mapView.autoresizingMask = self.view.autoresizingMask;
    
    self.view = [[RunningView alloc] initWithFrame:self.view.bounds];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [_popupController dismissPopupControllerAnimated:YES];
    };
    
    _popupController = [[CNPPopupController alloc] initWithContents:@[_mapView, button]];
    _popupController.theme = [CNPPopupTheme defaultTheme];
    _popupController.theme.popupStyle = CNPPopupStyleFullscreen;
    _popupController.delegate = self;

    _timeSession = [[TimeSession alloc] init];
    
    _timeSession.state = kSessionStateStart;
    _timeSession.startDate = [NSDate date];
    _timeSession.finishDate = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTask) userInfo:nil repeats:YES];
    
    _locations = [NSMutableArray new];
    _activity = [[Activity alloc] init];
    _activity.startTime = _timeSession.startDate;
    [self setUpEvent];
    
    [self kvoObserversInit];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //开启定位
    _mapView.showsUserLocation = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [[SOMotionDetector sharedInstance] startDetection];
}

- (void)viewDidDisappear:(BOOL)animated {
    //界面消失后必须关闭
//    [_timer invalidate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止更新位置
    [_locationManager stopUpdatingLocation];
    //停止计时器
    [_timer invalidate];
    [_kvoController unobserveAll];
}

- (void)setUpEvent {
    __weak typeof (self) weakSelf = self;
    
    RunningView *runningView = (RunningView *)self.view;
    [runningView.pauseOrContinueBtn bk_addEventHandler:^(id sender) {
        if (_bPause) {
            
            UIImage *btnImage = [[FAKIonIcons pauseIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
            [sender setImage:btnImage forState:UIControlStateNormal];
            //开启运动检测器
            [[SOMotionDetector sharedInstance] startDetection];
            //恢复定时器
            [_timer setFireDate:[NSDate date]];
            //恢复定位
            [_locationManager startUpdatingLocation];
            _bPause = FALSE;
        } else {
            UIImage *btnImage = [[FAKIonIcons playIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
            [sender setImage:btnImage forState:UIControlStateNormal];
            //暂停运动检测器
            [[SOMotionDetector sharedInstance] stopDetection];
            _timeSession.finishDate = [NSDate date];
//            _timeSession.finishDate = nil;
            //暂停定时器
            [_timer setFireDate:[NSDate distantFuture]];
            //暂停定位
            [_locationManager stopUpdatingLocation];
            
            _bPause = TRUE;
        }
    } forControlEvents:UIControlEventTouchDown];
    
    [runningView.goMapBtn bk_addEventHandler:^(id sender) {
        [_popupController presentPopupControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchDown];
    
    runningView.lockBtn.didUnlocked = ^{
        _activity.endTime = _timeSession.finishDate;
        _activity.activityDate = _timeSession.finishDate;
        float weight = [UserPreferences weight];
        NSNumber *totalCalories = [SportMathUtils caloriesFromDist:self.currentTotalDistance weight:weight overTime:[_activity.duration doubleValue]];
        _activity.calories = totalCalories;
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
            Activity *act = [Activity MR_createEntityInContext:localContext];
            act.distance = _activity.distance;
            act.pace = _activity.pace;
            act.duration = _activity.duration;
            act.activityDate = _activity.activityDate;
        } completion:^(BOOL success, NSError *error) {
            if (!error) {
                
                //如果有网络，并且已登陆，则保存到云端
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser != nil) {
                    AVObject *runActivity = [AVObject objectWithClassName:@"Activity"];
                    [runActivity setObject:_activity.pace forKey:@"Pace"];
                    [runActivity setObject:_activity.duration forKey:@"Duration"];
                    [runActivity setObject:_activity.distance  forKey:@"Distance"];
                    NSDate *date = [NSDate date];
                    [runActivity setObject:date forKey:@"RecordTime"];
                    [runActivity setObject:[AVUser currentUser] forKey:@"CreatedBy"];
                    //跑步日期
                    [runActivity setObject:_activity.activityDate forKey:@"ActivityDate"];
                    [runActivity setObject:_activity.locations forKey:@"Locations"];
                    [runActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        [runActivity saveEventually];
                    }];
                }
                //
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            } else {
            }
        }];
    };
}

- (void)mapViewInit {
//    __weak __typeof(self) weakSelf = self;
//    __block CLLocationCoordinate2D center;
//    self.locationRequestID = NSNotFound;
//    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10 delayUntilAuthorized:YES
//            block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//            if (status == INTULocationStatusSuccess) {
//                center = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
//            } else if (status == INTULocationStatusTimedOut) {
//                center = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
//                DDLogDebug(@"%s","222222");
//            } else {
//                DDLogDebug(@"%s","333333");
//            }
//    }];
    
    //定位管理器
    _locationManager = [[CLLocationManager alloc]init];
//
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的位置服务当前不可用，请打开位置服务后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 10.0;//十米定位一次
        _locationManager.distanceFilter = distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }

    
    [MAMapServices sharedServices].apiKey = API_MAP_KEY;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 35, SCREEN_HEIGHT - 80)];
    _mapView.delegate = self;
    //标准地图
    _mapView.mapType = MAMapTypeStandard;
    
    //地图跟着位置移动
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    _mapView.zoomLevel = 10.2;
    //后台定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    //自动定位
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
    
//    [_mapView addAnnotation:pointAnnotation];
    
    
    CLLocationCoordinate2D center = {23.126272 , 113.395568};
    // 也可以使用如下方式设置经、纬度
//    	center.latitude = latitude;
//    	center.longitude = longitude;
    // 设置地图显示的范围，
    MACoordinateSpan span;
    // 地图显示范围越小，细节越清楚
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    // 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
    MACoordinateRegion region = {center, span};
    [_mapView setRegion:region animated:YES];
//
//    [self.view addSubview:_mapView];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        NSDate *eventDate = newLocation.timestamp;
        
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        
        if (fabs(howRecent) < 10.0 && newLocation.horizontalAccuracy < 20) {
            // update distance
            if (_locations.count > 0) {
                self.currentTotalDistance += [newLocation distanceFromLocation:_locations.lastObject];
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)_locations.lastObject).coordinate;
                coords[1] = newLocation.coordinate;
                
                MACoordinateRegion region = MACoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500);
                [_mapView setRegion:region animated:YES];
                
                [_mapView addOverlay:[MAPolyline polylineWithCoordinates:coords count:2]];
            }
            
            [_locations addObject:newLocation];
            CLLocationCoordinate2D cc = newLocation.coordinate;
            NSValue *value = [[NSValue alloc] initWithBytes:&cc objCType:@encode(CLLocationCoordinate2D)];
            [_activity.locations addObject:value];
        }
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0];
        //pre.lineWidth = 3;
        //pre.lineDashPattern = @[@6, @3];
        pre.image = [UIImage imageNamed:@"location_image"];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)timerTask {
    if ((_timeSession) && (_timeSession.state == kSessionStateStart))
    {
        self.currentDuration += 1;
    }
}

- (void)initMotionDetector {
    [SOMotionDetector sharedInstance].delegate = self;
}

- (void)motionDetector:(SOMotionDetector *)motionDetector motionTypeChanged:(SOMotionType)motionType
{
    switch (motionType) {
        case MotionTypeNotMoving:
            self.currentMotionType = @"运动停止";
            break;
        case MotionTypeWalking:
            self.currentMotionType = @"步行状态";
            break;
        case MotionTypeRunning:
            self.currentMotionType = @"跑步状态";
            break;
        case MotionTypeAutomotive:
            self.currentMotionType = @"Automotive";
            break;
    }
}

- (void)motionDetector:(SOMotionDetector *)motionDetector locationChanged:(CLLocation *)location
{
    self.currentSpeed = motionDetector.currentSpeed;
}

- (void)motionDetector:(SOMotionDetector *)motionDetector accelerationChanged:(CMAcceleration)acceleration
{
    
}

- (void)kvoObserversInit {
    if (!_kvoController) {
        _kvoController = [FBKVOController controllerWithObserver:self];
    }

    [_kvoController observe:self keyPath:@"currentSpeed" options:NSKeyValueObservingOptionNew block:^(RunningViewController *rvc, id object, NSDictionary *change) {

        _activity.mph = [NSNumber numberWithDouble:[change[NSKeyValueChangeNewKey] doubleValue] * 3.6f];
        
        _activity.pace = [NSNumber numberWithDouble:(60 / [_activity.mph doubleValue])];
        
        RunningView *runningView = (RunningView *)rvc.view;
        
        runningView.currentPaceLabel.text = [NSString stringWithFormat:@"%.2f min/km", [_activity.pace doubleValue]];
    }];

    [_kvoController observe:self keyPath:@"currentDuration" options:NSKeyValueObservingOptionNew block:^(RunningViewController *rvc, id object, NSDictionary *change) {
        _timeSession.realSeconds = [change[NSKeyValueChangeNewKey] intValue];
        _activity.duration = [NSNumber numberWithDouble:_timeSession.realSeconds];
        RunningView *runningView = (RunningView *)self.view;
        runningView.currentTimeCostLabel.text = [CommonUtil stringFromTimeInterval:_timeSession.realSeconds shortDate:NO];
    }];
    
    [_kvoController observe:self keyPath:@"currentMotionType" options:NSKeyValueObservingOptionNew block:^(RunningViewController *rvc, id object, NSDictionary *change) {
        RunningView *runningView = (RunningView *)self.view;
        runningView.motionTypeLabel.text = change[NSKeyValueChangeNewKey];
    }];
    
    [_kvoController observe:self keyPath:@"currentTotalDistance" options:NSKeyValueObservingOptionNew block:^(RunningViewController *rvc, id object, NSDictionary *change) {
        _activity.distance = [NSNumber numberWithDouble:([change[NSKeyValueChangeNewKey] doubleValue] / 1000)];
        RunningView *runningView = (RunningView *)rvc.view;
        runningView.currentDistanceLabel.text = [NSString stringWithFormat:@"%.2f", [_activity.distance doubleValue]];
    }];

}
@end
