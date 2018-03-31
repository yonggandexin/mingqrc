//
//  MQAlertTool.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MQJobWantedController;
@interface MQAlertTool : NSObject
+(void)showMessageTool:(UIViewController *)vc;
//是否去创建简历
+(void)goToCreatResume:(UIViewController *)vc;
@end
