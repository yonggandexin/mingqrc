//
//  MQTabBarControllerConfig.m
//  mqrc
//
//  Created by 朱波 on 2018/1/9.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTabBarControllerConfig.h"
#import <UIKit/UIKit.h>
#import "MQHeader.h"
#import "MQMeController.h"
#import "CYLTabBarController.h"
#import "MQEqHomeController.h"
@interface MQTabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end
@implementation MQTabBarControllerConfig
/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                                                                 context:self.context
                                                 ];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 //                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"homePage_IsNotSelected",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"homePage_ Selected", /* NSString and UIImage are supported*/
                                                 };
   
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  //                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"SmilingFace_ isNotSelected",
                                                  CYLTabBarItemSelectedImage : @"SmilingFace_ selected"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (NSArray *)viewControllers {
   
    MQEqHomeController *firstViewController = [[MQEqHomeController alloc] init];
     MQNavigationController*firstNavigationController = [[MQNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
   
    
    MQMeController *fourthViewController = [[MQMeController alloc] init];
    MQNavigationController *fourthNavigationController = [[MQNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 45;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabRectangle"]];
    
    // set the bar background image
    // 设置背景图片
    
    UITabBar *tabBarAppearance = [UITabBar appearance];
    //FIXED: #196
    [tabBarAppearance setShadowImage:[[UIImage alloc] init]];
    [tabBarAppearance setBackgroundImage:[[UIImage alloc] init]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
  
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
