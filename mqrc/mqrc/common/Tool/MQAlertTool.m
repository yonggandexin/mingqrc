//
//  MQAlertTool.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAlertTool.h"
#import <UIKit/UIKit.h>
#import "MQHeader.h"
#import "MQJobWantedController.h"
@implementation MQAlertTool
+(void)showMessageTool:(UIViewController *)vc
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定离开吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //UIAlertActionStyleCancel
    UIAlertAction *one = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:one];
    UIAlertAction *two = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:two];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

+(void)goToCreatResume:(UIViewController *)vc
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您还未创建简历噢" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //UIAlertActionStyleCancel
    UIAlertAction *one = [UIAlertAction actionWithTitle:@"去创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [vc.navigationController pushViewController:[MQJobWantedController new] animated:YES];
    }];
    [alertVC addAction:one];
    UIAlertAction *two = [UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:two];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@end
