//
//  MQCertificateController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
typedef void(^addBlock) (NSArray *);
@class MQIndustyModel;
@interface MQCertificateController : UIViewController
@property (nonatomic, copy) addBlock alreadyM;
@property (nonatomic, strong) NSArray *addModels;
@end
