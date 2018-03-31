//
//  MQTransferDesController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQTranShowModel;
@interface MQTransferDesController : UIViewController
@property (nonatomic, strong) MQTranShowModel *model;
@property (nonatomic, assign) BOOL isMine;
@end
