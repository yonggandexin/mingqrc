//
//  MQTabBarControllerConfig.h
//  mqrc
//
//  Created by 朱波 on 2018/1/9.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYLTabBarController;
@interface MQTabBarControllerConfig : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;
@end
