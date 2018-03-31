//
//  MQMtTransferVC.m
//  mqrc
//
//  Created by 朱波 on 2018/1/9.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMtTransferVC.h"
#import "MQHeader.h"
#import "MQGuessLikeCell.h"
#import "MQTranShowModel.h"
#import "MQTransferDesController.h"
@interface MQMtTransferVC ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation MQMtTransferVC
- (instancetype)init
{
    if (self = [super init]) {
        self.isLoad = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的转让";
    self.tableView.y = 0;
    self.tableView.height = SCREEN_HEIGHT-nav_barH;
    [self loadTransferData];
}



- (void)loadTransferData
{
    NSDictionary *pram =@{
                          @"checkStatus":@(0),
                          @"pageIndex":@(1),
                          @"pageSize":@(10)
                          };
    [self showHudWithTitle:@"加载中..."];
    _task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getPublishTransferList withParameters:pram success:^(id res) {
         [self hideHudVCview];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQTranShowModel *model = [MQTranShowModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
        self.tableView.models = self.models;
    } failure:^(id error) {
        [self hideHudVCview];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_task cancel];
}

- (BOOL)isMine
{
    return YES;
}
@end
