//
//  MQNewsController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQNewsController.h"
#import "MQHeader.h"
#import "MQNewsCell.h"
#import "MQNewsModel.h"
#import "MQWebViewController.h"
@interface MQNewsController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MQNewsController
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"消息";
    
    [self initUI];
    
    [self loadData];

}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = baseColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellNibName:[MQNewsCell class]];
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudWithTitle:@"加载中..."];
    self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetNewsLis withParameters:pram success:^(id res) {
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQNewsModel *model = [MQNewsModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [_tableView reloadData];
        [self hideHudVCview];
    } failure:^(id error) {
        [self hideHudVCview];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQNewsModel *model = self.models[indexPath.row];
    MQNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQNewsCell class])];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQWebViewController *webVC = [MQWebViewController new];
    MQNewsModel *model = self.models[indexPath.row];
    webVC.title = model.Title;
    webVC.Url = model.Url;
    [self.navigationController pushViewController:webVC animated:YES];
}
@end
