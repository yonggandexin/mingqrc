//
//  MQAddCerController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@class MQIndustyModel;
typedef void(^addBlock) (NSArray *);
@interface MQAddCerController : MQEmpyDataController
@property (nonatomic, copy) addBlock alreadyBlock;
@property (nonatomic, strong) NSArray *addModels;
@end
