//
//  MQEmpyDataController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@interface MQEmpyDataController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy, readonly) NSString *desStr;
@property (nonatomic, copy, readonly) NSString *imgName;
@end
