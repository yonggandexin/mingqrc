//
//  UIViewController+MQHud.h
//  mqrc
//
//  Created by 朱波 on 2017/12/14.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIViewController (MQHud)
- (void)hudNavWithTitle:(NSString *)title;

- (void)hideHudFromNav;

- (void)showHudWithTitle:(NSString *)title;

- (void)hideHudVCview;
@end
