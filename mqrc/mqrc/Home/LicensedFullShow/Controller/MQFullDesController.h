//
//  MQFullDesController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQFullModel;
@interface MQFullDesController : UIViewController
@property (nonatomic, strong) MQFullModel *model;
@property (nonatomic, assign) BOOL isMine;
@end
