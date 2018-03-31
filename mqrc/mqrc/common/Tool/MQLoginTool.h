//
//  MQLoginTool.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQHeader.h"
@class MQLoginModel;



@interface MQLoginTool : NSObject
@property (nonatomic, strong) MQLoginModel *model;

+ (instancetype)shareInstance;
/**
 弹出登录控制器
 */
+ (void)presentLogin;


+ (void)updateModel;

+ (void)initAlias;

+ (void)deleteAlias;


@end
