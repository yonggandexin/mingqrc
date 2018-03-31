//
//  MQPushTool.m
//  mqrc
//
//  Created by 朱波 on 2018/1/16.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQPushTool.h"
#import "MQPushModel.h"
#import "MQHeader.h"
#import "MQRecruitCerController.h"
#import "CYLTabBarController.h"
#import "MQEqHomeController.h"
#import "MQEnterCerListController.h"
@implementation MQPushTool
- (void)setModel:(MQPushModel *)model
{
    _model = model;
    UIApplicationState appState = [UIApplication sharedApplication].applicationState;
    /*
     UIApplicationStateActive,
     UIApplicationStateInactive,
     UIApplicationStateBackground
    */
    if(appState == UIApplicationStateActive){
        
    }
    switch (model.PushType) {
        case 0:
        {
            /*
             UIApplicationStateActive,
             UIApplicationStateInactive,
             UIApplicationStateBackground
            */
           
            //去股权转让企业认证列表查看状态
            UIViewController *currentVC = [self toJobComController];
            MQEnterCerListController *message = [[MQEnterCerListController alloc] init];
            [currentVC.navigationController pushViewController:message animated:YES];
            if(model.StateCheck == 0){
//                 [MBProgressHUD showAutoMessage:@"您的股权转让企业认证审核失败,需再次认证"];
            }else{
//                [MBProgressHUD showAutoMessage:@"您的股权转让企业认证审核成功"];
            }
        }
            break;
        case 1:
        {
            //去招聘企业认证列表查看状态
           UIViewController *currentVC = [self toJobComController];
           MQRecruitCerController *message = [[MQRecruitCerController alloc] init];
           [currentVC.navigationController pushViewController:message animated:YES];
            if(model.StateCheck == 0){
                 [MBProgressHUD showAutoMessage:@"您的企业招聘企业证认证审核失败,需再次认证"];
            }else{
                 [MBProgressHUD showAutoMessage:@"您的企业招聘企业证认证审核成功"];
            }
           
        }
            break;
        case 2:
        {
            if (model.StateCheck == 0) {
                UIViewController *currentVC = [self toJobComController];
                MQRecruitCerController *message = [[MQRecruitCerController alloc] init];
                [currentVC.navigationController pushViewController:message animated:YES];
                [MBProgressHUD showAutoMessage:@"您的企业招聘身份证认证审核失败,需再次认证"];
            }else{
                MQLoginModel *model = [MQLoginTool shareInstance].model;
                model.IS_USER_AUTH = 1;
                [MQLoginTool shareInstance].model = model;
                [MBProgressHUD showAutoMessage:@"恭喜您!招聘认证审核成功,马上发布招聘吧"];
            }
        }
            break;
        case 3:
        {
            //登录失效 删除别名
            [MQLoginTool deleteAlias];
            //删除用户模型
            [MQLoginTool updateModel];
            [MBProgressHUD showAutoMessage:@"您的账号在别的设备上登录,请及时更改密码"];
        }
            break;
        default:
            break;
    }
}


- (UIViewController *)toJobComController
{
    /*
     获取当前展示的视图
     */
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *topVC = appRootVC;
        UIViewController *currentVC = nil;
        if (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
            XLOG(@"数组:%@", topVC.childViewControllers);
            XLOG(@"模态出最外层的视图%@", [topVC.childViewControllers lastObject]);
            //有模态情况下的根视图
            currentVC = [topVC.childViewControllers lastObject];
        } else {
            //获取非模态情况下的根视图
            currentVC = [self getCurrentVC];
        }
        //在下方就可以执行你想做的事情了--(比如)通过当前展示的视图直接进入消息推送界面,当你pop回来的时候还是你之前的那个界面
        
       return currentVC;
//         message.hidesBottomBarWhenPushed = YES;
    
//    }else if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
//         [MBProgressHUD showAutoMessage:@"1"];
//    }else{
//         [MBProgressHUD showAutoMessage:@"2"];
//    }
    
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    /*
     *  在此判断返回的视图是不是你的根视图--我的根视图是tabbar
     */
    if ([result isKindOfClass:[CYLTabBarController class]]) {
        CYLTabBarController *mainTabBarVC = (CYLTabBarController *)result;
        result = [mainTabBarVC selectedViewController];
        result = [result.childViewControllers lastObject];
    }
    
    XLOG(@"非模态视图%@", result);
    return result;
}

@end
