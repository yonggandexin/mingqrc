//
//  MQPartJobController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQPartJobController.h"
#import "MQHeader.h"
#import "MQPartShowCell.h"
#import "MQPartModel.h"
#import "MQPartDesController.h"
@interface MQPartJobController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQPartJobController
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
    [self.tableView registerCellNibName:[MQPartShowCell class]];
    
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"Item":@(3),
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_collectionList withParameters:pram success:^(id res) {
        [self.models removeAllObjects];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQPartModel *model = [MQPartModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQPartShowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQPartShowCell class])];
    MQPartModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MQPartModel *model = self.models[indexPath.row];
    MQPartDesController *desVC = [MQPartDesController new];
    desVC.model = model;
    [self.navigationController pushViewController:desVC animated:YES];
}

- (NSString *)desStr
{
    return @"无收藏数据";
}
@end
