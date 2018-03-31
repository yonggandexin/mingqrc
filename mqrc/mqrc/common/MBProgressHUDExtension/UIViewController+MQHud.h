//
//  UIViewController+MQHud.h
//  mqrc
//
//  Created by 朱波 on 2017/12/7.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MQHud)

/*
 *hud显示在导航控制器器view上
 */
- (void)showHudNavViewWithTitle:(NSString *)title;

/*
 *hud从导航控制器view上隐藏
 */
- (void)hideHudNavView;
@end
