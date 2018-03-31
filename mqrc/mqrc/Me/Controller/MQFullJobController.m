//
//  MQFullJobController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQFullJobController.h"
#import "MQHeader.h"
#import "MQFullShowCell.h"
#import "MQFullModel.h"
#import "MQFullDesController.h"
@interface MQFullJobController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQFullJobController
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
    [self.tableView registerCellNibName:[MQFullShowCell class]];
    
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"Item":@(2),
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_collectionList withParameters:pram success:^(id res) {
        [self.models removeAllObjects];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQFullModel *model = [MQFullModel mj_objectWithKeyValues:obj];
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
    MQFullShowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQFullShowCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MQFullModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MQFullModel *model = self.models[indexPath.row];
    MQFullDesController *desVC = [MQFullDesController new];
    desVC.model = model;
    [self.navigationController pushViewController:desVC animated:YES];
}
- (NSString *)desStr
{
    return @"无收藏数据";
}
@end
