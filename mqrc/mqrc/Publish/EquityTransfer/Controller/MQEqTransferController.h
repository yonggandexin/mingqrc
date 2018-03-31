//
//  MQEqTransferController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQIndustyModel,MQCheckStateModel,MQTranShowModel;
@interface MQEqTransferController : UIViewController
@property (nonatomic, assign) BOOL isMine;
@property (nonatomic, strong) MQCheckStateModel *stateModel;
@property (nonatomic, strong) MQTranShowModel *transModel;
@end
