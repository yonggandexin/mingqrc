//
//  MQPartDesController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQPartModel;
@interface MQPartDesController : UIViewController
@property (nonatomic, strong) MQPartModel *model;
@property (nonatomic, assign) BOOL isMine;
@end
