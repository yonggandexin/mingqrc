//
//  MQSetNotiCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/15.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQSetNotiCell.h"
#import "MQHeader.h"
#import <UserNotifications/UserNotifications.h>
@interface MQSetNotiCell()

@property (nonatomic, strong) UISwitch *switchV;

@end
@implementation MQSetNotiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [MQNotificationCent addObserver:self selector:@selector(isUserAllowPushNoti) name:isAllowNoti object:nil];
        [self initUI];
        [self isUserAllowPushNoti];
    }
    return self;
}

- (void)initUI
{
    self.titleL = [UILabel new];
    self.titleL.textAlignment = NSTextAlignmentLeft;
    self.titleL.textColor = [UIColor grayColor];
    self.titleL.font = font(15);
    self.titleL.x = 10;
    self.titleL.y = 0;
    self.titleL.height = self.contentView.height;
    self.titleL.width = 150;
    [self.contentView addSubview:self.titleL];
    
    UISwitch *switchV = [[UISwitch alloc]init];
    [switchV addTarget:self action:@selector(isAllowPushNoti) forControlEvents:UIControlEventTouchUpInside];
    switchV.width = 60;
    switchV.height = 35;
    switchV.x = SCREEN_WIDTH-switchV.width-10;
    switchV.centerY = self.contentView.centerY;
    [self.contentView addSubview:switchV];
    _switchV = switchV;
    
}

- (void)isUserAllowPushNoti
{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined)
            
        {
//            XLOG(@"未选择---没有选择允许或者不允许，按不允许处理");
             [self changeSwitchState:NO];
            
        }else if (settings.authorizationStatus == UNAuthorizationStatusDenied){
            
//            XLOG(@"未授权--不允许推送");
             [self changeSwitchState:NO];
            
        }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){

//            XLOG(@"已授权--允许推送");
            [self changeSwitchState:YES];
           
        }
        
    }];
}

- (void)isAllowPushNoti
{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
        NSURL *url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (IS_OS_10_OR_LATER) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }}

- (void)changeSwitchState:(BOOL)isOn
{
    dispatch_async(dispatch_get_main_queue(), ^{
         _switchV.on = isOn;
    });
}
- (void)dealloc
{
    [MQNotificationCent removeObserver:self];
}
@end
