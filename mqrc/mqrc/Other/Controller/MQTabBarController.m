//
//  MQTabBarController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTabBarController.h"
#import "MQNavigationController.h"
#import "MQEqHomeController.h"
#import "MQTypeController.h"
#import "MQPublishController.h"
#import "MQNewsController.h"
#import "MQMeController.h"
#import "MQTabBar.h"
@interface MQTabBarController ()

@end

@implementation MQTabBarController


+(void)initialize
{
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
//    [self setupChildVc:[[MQHomeViewController alloc] init] title:@"首页" image:@"home_normal" selectedImage:@"home_highlight"];
    
//    [self setupChildVc:[[MQTypeController alloc] init] title:@"类别" image:@"category_normal" selectedImage:@"category_highlight"];
    
//    [self setupChildVc:[[MQNewsController alloc] init] title:@"消息" image:@"message_normal" selectedImage:@"message_highlight"];
    
    [self setupChildVc:[[MQMeController alloc] init] title:@"我" image:@"person_normal" selectedImage:@"person_highlight"];
    
    // 更换tabBar
    //        self.tabBar = [[ZBTabBar alloc] init];
    [self setValue:[[MQTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    MQNavigationController *zbNavc = [[MQNavigationController alloc]initWithRootViewController:vc];
    // 添加为子控制器
    [self addChildViewController:zbNavc];
}


@end
