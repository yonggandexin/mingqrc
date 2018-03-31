//
//  MQEqAcquisController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQAcqDesModel;
@interface MQEqAcquisController : UIViewController
@property (nonatomic, strong) MQAcqDesModel *model;
@property (nonatomic, assign) BOOL isMine;
@end
