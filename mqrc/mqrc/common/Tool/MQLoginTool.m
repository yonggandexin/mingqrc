//
//  MQLoginTool.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQLoginTool.h"
#import "MQHeader.h"
#import "JPUSHService.h"
#import "MQLoginModel.h"
static MQLoginTool *_instance;
@implementation MQLoginTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //    NSLog(@"%s", __FUNCTION__);
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MQLoginTool alloc] init];
    });
    return _instance;
}


+ (void)presentLogin
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = rootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    MQNavigationController *loginNV = [[MQNavigationController alloc]initWithRootViewController:[MQLoginController new]];
    
    [topVC presentViewController:loginNV animated:YES completion:nil];
}

- (void)setModel:(MQLoginModel *)model
{
    [[NSUserDefaults standardUserDefaults] setObject:model.MOBILE forKey:login_userName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BOOL isCode = [NSKeyedArchiver archiveRootObject:model toFile:path_usermodel];
    if (isCode == YES) {
        XLOG(@"归档成功");
        NSNotification *noti = [NSNotification notificationWithName:starLogin object:nil];
        [MQNotificationCent postNotification:noti];
    }else{
        XLOG(@"归档失败");
    }
}

- (MQLoginModel *)model
{
   MQLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:path_usermodel];
    if (model) {
        return model;
    }
    return nil;
}


+(void)updateModel
{
    //文件名
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:path_usermodel];
    if (!blHave) {
        XLOG(@"找不到路径");
        return ;
    }else {
        BOOL blDele= [[NSFileManager defaultManager] removeItemAtPath:path_usermodel error:nil];
        if (blDele) {
            XLOG(@"注销成功");
        }else {
            XLOG(@"注销失败");
        }
    }
}

+ (void)initAlias
{
    [JPUSHService setAlias:[MQLoginTool shareInstance].model.ID completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            XLOG(@"Alias设置成功");
        }else{
            XLOG(@"Alias设置失败");
        }
    } seq:0];
}

+ (void)deleteAlias
{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            XLOG(@"Alias删除成功");
        }else{
            XLOG(@"Alias删除失败");
        }
    } seq:1];
}


@end
