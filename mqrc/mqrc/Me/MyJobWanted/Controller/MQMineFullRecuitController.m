//
//  MQMineFullRecuitController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/11.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMineFullRecuitController.h"
#import "MQHeader.h"
#import "MQFullShowCell.h"
#import "MQFullDesController.h"
#import "MQFullModel.h"
@interface MQMineFullRecuitController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) MQEmptTableView *tableView;
@end

@implementation MQMineFullRecuitController

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH-35) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = baseColor;
    [self.view addSubview:self.tableView];
    [self.tableView registerCellNibName:[MQFullShowCell class]];
    
    [self loadData];
    
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"Type":@(0),
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudWithTitle:@"请求中..."];
   self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:_urlStr withParameters:pram success:^(id res) {
        [self hideHudVCview];
        [self.models removeAllObjects];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQFullModel *model = [MQFullModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
        self.tableView.models = self.models;
    } failure:^(id error) {
        self.tableView.models = self.models;
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
    desVC.isMine = self.isMine;
    [self.navigationController pushViewController:desVC animated:YES];
}
@end
