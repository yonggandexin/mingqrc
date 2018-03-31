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
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQMyTakeoverController
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
    self.tableView.y = 35;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = baseColor;
    [self.tableView registerCellNibName:[MQGuessLikeCell class]];
    
}

- (void)loadData
{
    
    //API_collectionList
    NSDictionary *pram = @{
                           @"Item":@(0),
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_collectionList withParameters:pram success:^(id res) {
        [self.models removeAllObjects];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQTranShowModel *model = [MQTranShowModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
    } failure:^(id error) {
        
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
    [self.navigationController pushViewController:transferVC animated:YES];
}

- (NSString *)desStr
{
    return @"无收藏数据";
}
@end
