//
//  MQMyPubTakeOverVC.m
//  mqrc
//
//  Created by 朱波 on 2018/1/9.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMyPubTakeOverVC.h"
#import "MQEqModel.h"
@interface MQMyPubTakeOverVC ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation MQMyPubTakeOverVC
- (instancetype)init
{
    if (self = [super init]) {
        self.isLoad = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收购";
    self.tableView.y = 0;
    self.tableView.height = SCREEN_HEIGHT-nav_barH;
    [self loadEqData];
}

- (void)loadEqData
{
    NSDictionary *pram =@{
                          @"takeoverType":@(0),
                          @"checkStatus":@(0),
                          @"pageIndex":@(1),
                          @"pageSize":@(10)
                          };
    [self showHudWithTitle:@"加载中..."];
   _task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getPublishTakeOverList withParameters:pram success:^(id res) {
       [self hideHudVCview];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQEqModel *model = [MQEqModel mj_objectWithKeyValues:obj];
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
