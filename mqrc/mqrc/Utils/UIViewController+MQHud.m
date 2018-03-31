//
//  UIViewController+MQHud.m
//  mqrc
//
//  Created by 朱波 on 2017/12/14.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "UIViewController+MQHud.h"
#import "MBProgressHUD+NH.h"
@implementation UIViewController (MQHud)
- (void)hudNavWithTitle:(NSString *)title
{
    [MBProgressHUD showMessage:title ToView:self.navigationController.view];
}

- (void)hideHudFromNav
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)showHudWithTitle:(NSString *)title
{
    [MBProgressHUD showMessage:title ToView:self.view];
}

- (void)hideHudVCview
{
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
