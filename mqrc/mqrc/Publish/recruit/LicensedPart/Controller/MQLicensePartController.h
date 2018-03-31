//
//  MQKicensePartController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/21.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@interface MQLicensePartController : MQCancelDataController
@property (nonatomic, assign) BOOL isMine;

@property (nonatomic, copy) NSString *ID;
@end
