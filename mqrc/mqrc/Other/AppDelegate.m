//
//  AppDelegate.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "AppDelegate.h"
#import "MQTabBarController.h"
#import "MQHeader.h"
#import "MQPushModel.h"
#import "MQPushTool.h"
#import "LocaltionInstance.h"
#import "MQPlusButtonSubclass.h"
#import "MQTabBarControllerConfig.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "JPUSHService.h"
#import "MQLunchTool.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()
<
UITabBarControllerDelegate,
CYLTabBarControllerDelegate,
JPUSHRegisterDelegate
>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationIconBadgeNumber = 0;
    //获取APP基本信息
    [[MQLunchTool shareInstance] getAPPBaseData];

    //初始化分享
    [self initShare];
    //配置地图SDK
    [AMapServices sharedServices].apiKey = Gaode_key;
    //获取当前所在省份
    [[LocaltionInstance shareInstance] findMe];
    
    [MQPlusButtonSubclass registerPlusButton];
    
    MQTabBarControllerConfig *tabBarControllerConfig = [[MQTabBarControllerConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    tabBarController.delegate = self;
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
//    MQTabBarController *tabVC = [MQTabBarController new];
    
    // 设置窗口的根控制器
    self.window.rootViewController = tabBarController;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
     [self customizeInterfaceWithTabBarController:tabBarController];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    
    
    //注册APNs
    [self initAPNs];
    //初始化JPushJPush
    [self initJPush:launchOptions];
    return YES;
}

- (void)initAPNs
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if (iOS8Later) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
}

- (void)initJPush:(NSDictionary *)launchOptions
{
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    BOOL isProduction;
#ifdef DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    [JPUSHService setupWithOption:launchOptions appKey:PushKey
                          channel:nil
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    // [MQNotificationCent addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    if(launchOptions){
        NSDictionary *remoteNoti = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNoti) {
//            [self pushStateWithInfo:remoteNoti];
        }
    }
}

- (void)initShare
{
    NSArray *platforms = @[
                           @(SSDKPlatformTypeWechat),
                           @(SSDKPlatformTypeQQ)];
    [ShareSDK registerActivePlatforms:platforms onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
           
            case SSDKPlatformTypeWechat:
            {
                [ShareSDKConnector connectWeChat:[WXApi class]];
            }
                break;
            case SSDKPlatformTypeQQ:
            {
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            }
            default:
                break;
        }
        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
            switch (platformType) {
                
                case SSDKPlatformTypeWechat:
                {
                    [appInfo SSDKSetupWeChatByAppId:WECHATAPPID
                                          appSecret:WECHATAPPKEY];
                }
                    break;
                case SSDKPlatformTypeQQ:
                {
                    [appInfo SSDKSetupQQByAppId:QQAPPID
                                         appKey:QQAPPKEY
                                       authType:SSDKAuthTypeBoth];
                }
                    break;
                default:
                    break;
            }
            
        }];
}

- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    //设置导航栏
//    [self setUpNavigationBarAppearance];
    
    [tabBarController hideTabBadgeBackgroundSeparator];
    //添加小红点
    UIViewController *viewController = tabBarController.viewControllers[0];
    UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:mainColor radius:4.5];
    [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
//    [viewController cyl_showTabBadgePoint];
    
    UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:mainColor radius:4.5];
    @try {
//        [tabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
//        [tabBarController.viewControllers[1] cyl_showTabBadgePoint];
        
//        UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
//        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
//        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
//
//        [tabBarController.viewControllers[3] cyl_showTabBadgePoint];
        
        //添加提示动画，引导用户点击
//        [self addScaleAnimationOnView:tabBarController.viewControllers[0].cyl_tabButton.cyl_tabImageView repeatCount:20];
    } @catch (NSException *exception) {}
}


//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    
    if ([control cyl_isTabButton]) {
        //更改红标状态
        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
//            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        } else {
//            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
        }
        
        animationView = [control cyl_tabImageView];
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
     
    
//    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
        [self addScaleAnimationOnView:animationView repeatCount:1];
//    } else {
//        [self addRotateAnimationOnView:animationView];
//    }
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{

    return YES;
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    XLOG(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSDictionary *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    MQPushModel *model = [MQPushModel mj_objectWithKeyValues:[customizeField1 objectForKey:@"extras"]];
    MQPushTool *tool = [MQPushTool new];
    tool.model = model;
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
}

//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 本地通知
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [self pushStateWithInfo:userInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)pushStateWithInfo:(NSDictionary *)userInfo
{
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if (userInfo) {
        MQPushModel *model = [MQPushModel mj_objectWithKeyValues:[userInfo objectForKey:@"extras"]];
        MQPushTool *tool = [MQPushTool new];
        tool.model = model;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSNotification *noti = [NSNotification notificationWithName:isAllowNoti object:nil];
    [MQNotificationCent postNotification:noti];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
