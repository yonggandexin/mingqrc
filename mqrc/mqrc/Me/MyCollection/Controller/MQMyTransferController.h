//
//  MQTransferController.h
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@interface MQMyTransferController : UIViewController
@property (nonatomic, assign) BOOL isMine;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) MQEmptTableView *tableView;
- (void)loadData;
@end
