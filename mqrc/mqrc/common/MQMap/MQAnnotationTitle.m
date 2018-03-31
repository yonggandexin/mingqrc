//
//  MQAnnotationTitle.m
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAnnotationTitle.h"
#import "MQHeader.h"
@interface MQAnnotationTitle()

- (IBAction)sureClicked:(id)sender;

@end
@implementation MQAnnotationTitle

- (IBAction)sureClicked:(id)sender
{
    NSNotification *noti = [NSNotification notificationWithName:SureAddres_des object:_titleL.text];
    [MQNotificationCent postNotification:noti];
}

@end
