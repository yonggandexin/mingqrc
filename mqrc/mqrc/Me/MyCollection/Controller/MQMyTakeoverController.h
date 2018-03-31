//
//  MQMyTakeoverController.h
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@interface MQMyTakeoverController : UIViewController
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) MQEmptTableView *tableView;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, assign) BOOL isMine;
- (void)loadData;
@end
