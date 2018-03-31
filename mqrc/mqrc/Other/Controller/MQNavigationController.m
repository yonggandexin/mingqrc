//
//  MQNavigationController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQNavigationController.h"
#import "MQResaultController.h"
#import "MQEqAcquisController.h"
#import "MQEqTransferController.h"
#import "MQAlertTool.h"
#import "MQHeader.h"
#import "MQRecruitComController.h"
#import "MQPubLicenseFullController.h"
#import "MQLicensePartController.h"
#import "MQJobWantedController.h"
#import "MQPreviewResumeVC.h"
@interface MQNavigationController ()

@end

@implementation MQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationBar.translucent = NO;

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        
        BackBtn *btn = [BackBtn buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"nav_back_w"] forState:UIControlStateNormal];
        
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        btn.bounds = CGRectMake(0, 0, 70, 30);
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.fd_interactivePopDisabled = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

- (void)back{
    //获取到当前控制器
    UIViewController *vc =  self.viewControllers[self.viewControllers.count-1];
    if ([vc isKindOfClass:[MQResaultController class]]||[vc isKindOfClass:[MQPreviewResumeVC class]]) {
        [self popToRootViewControllerAnimated:YES];
        return;
    }
    
    if ([vc isKindOfClass:[MQEqAcquisController class]]) {
        [MQAlertTool showMessageTool:vc];
        return;
    }
    
    if ([vc isKindOfClass:[MQEqTransferController class]]) {
        [MQAlertTool showMessageTool:vc];
        return;
    }
    
    if ([vc isKindOfClass:[MQRecruitComController class]]) {
         [MQAlertTool showMessageTool:vc];
        return;
    }
    
    if ([vc isKindOfClass:[MQPubLicenseFullController class]]) {
        [MQAlertTool showMessageTool:vc];
        return;
    }
    
    if ([vc isKindOfClass:[MQLicensePartController class]]) {
        [MQAlertTool showMessageTool:vc];
        return;
    }
    
    if ([vc isKindOfClass:[MQJobWantedController class]]) {
        [MQAlertTool showMessageTool:vc];
        return;
    }
    [self popViewControllerAnimated:YES];
}

@end

@implementation BackBtn
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 3;
    
    self.imageView.width = 25;
    
    self.imageView.height = 25;
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
