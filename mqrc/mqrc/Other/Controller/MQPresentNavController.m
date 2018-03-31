//
//  MQPresentNavController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/18.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPresentNavController.h"
#import "MQHeader.h"
@implementation MQPresentNavController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav3"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15],
                                     NSForegroundColorAttributeName : [UIColor blackColor]
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        
        
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

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
