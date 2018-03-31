//
//  MQIndustyController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@class MQCheckStateModel;
@interface MQIndustyController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) ShareType eqType;
@property (nonatomic, strong) MQCheckStateModel *model;
@end
