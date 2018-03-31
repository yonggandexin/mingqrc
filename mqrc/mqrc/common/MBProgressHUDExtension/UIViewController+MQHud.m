//
//  UIViewController+MQHud.m
//  mqrc
//
//  Created by 朱波 on 2017/12/7.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "UIViewController+MQHud.h"
#import "MBProgressHUD+NH.h"
@implementation UIViewController (MQHud)
- (void)showHudNavViewWithTitle:(NSString *)title
{
   [MBProgressHUD showMessage:title ToView:self.navigationController.view];
}

- (void)hideHudNavView
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}
@end
