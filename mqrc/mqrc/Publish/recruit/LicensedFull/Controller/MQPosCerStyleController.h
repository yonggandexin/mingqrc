//
//  MQPosCerStyleController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/16.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQPosCerModel;
typedef void(^modelsBlock)(NSArray <MQPosCerModel *>*);
@interface MQPosCerStyleController : UIViewController

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) modelsBlock typeBlock;
@property (nonatomic, strong) NSArray *addModels;
@end
