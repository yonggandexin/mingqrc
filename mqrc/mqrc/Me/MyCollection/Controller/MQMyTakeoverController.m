//
//  MQMyTakeoverController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMyTakeoverController.h"
#import "MQHeader.h"
#import "MQTranShowModel.h"
#import "MQGuessLikeCell.h"
#import "MQTransferDesController.h"
@interface MQMyTakeoverController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation MQMyTakeoverController
- (instancetype)init
{
    if (self = [super init]) {
        _isLoad = YES;
    }
    return self;
}
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH-35) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = baseColor;
    [self.view addSubview:self.tableView];
    [self.tableView registerCellNibName:[MQGuessLikeCell class]];
    
}

- (void)loadData
{
 
    if (_isLoad == NO) return;
    NSDictionary *pram = @{
                           @"Item":@(0),
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudWithTitle:@"请求中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_collectionList withParameters:pram success:^(id res) {
        [self hideHudVCview];
        [self.models removeAllObjects];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQGuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQGuessLikeCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MQTranShowModel *model = self.models[indexPath.row];
    cell.transModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MQTranShowModel *model = self.models[indexPath.row];
    MQTransferDesController *transferVC = [MQTransferDesController new];
    transferVC.model = model;
    transferVC.isMine = self.isMine;
    [self.navigationController pushViewController:transferVC animated:YES];
}

- (NSString *)desStr
{
    return @"无收藏数据";
}

- (NSString *)imgName
{
    return @"ConnectionError";
}
@end
