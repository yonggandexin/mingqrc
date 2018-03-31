//
//  MQLunchTool.m
//  mqrc
//
//  Created by 朱波 on 2018/1/24.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQLunchTool.h"
#import "MQHeader.h"
#import "MQVersionView.h"
static MQLunchTool *_instance;
@implementation MQLunchTool
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
        _instance = [[MQLunchTool alloc] init];
    });
    return _instance;
}

- (void)getAPPBaseData
{
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_InitIOSData withParameters:nil success:^(id res) {
        NSString *version = [res objectForKey:@"Version"];
        NSString *baseUrl = [res objectForKey:@"ImgService"];
        //检查是否有新版本
        [self checkNewVersion:version];
        
        //存储图片基地址
        [self storageImgBaseUrl:baseUrl];
    } failure:^(id error) {
       
        
    }];
}

- (void)storageImgBaseUrl:(NSString *)baseUrl
{
    [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:storageImgUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.imgBaseUrl = baseUrl;
}

- (NSString *)imgBaseUrl
{
    NSString *imgUrl = [[NSUserDefaults standardUserDefaults] objectForKey:storageImgUrl];
    if (imgUrl) {
        return imgUrl;
    }
    XLOG(@"获取图片基地址失败");
    return @"";
}


- (void)checkNewVersion:(NSString *)version
{
    NSString *localVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (localVer) {
        if (![localVer isEqualToString:version]) {
            [self showVersionView:version];
        }
    }
}

- (void)showVersionView:(NSString *)version
{
    UIView *backV = [UIView new];
    backV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    backV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:backV];
    MQVersionView *verView = [self creatWithXIB:@"MQVersionView"];
    verView.versionSer = [NSString stringWithFormat:@"V%@", version];
    verView.width = 260;
    verView.height = 340;
    verView.centerX = backV.width*0.5;
    verView.centerY = backV.height*0.5;
    [backV addSubview:verView];
    
}
@end
