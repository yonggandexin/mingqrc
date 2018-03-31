//
//  MQTypeListController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/6.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTypeListController.h"
#import "MQHeader.h"
#import "MQTrainListModel.h"
#import "MQTrainListCell.h"
#import "MQTrainDesController.h"
@interface MQTypeListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) MQEmptTableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQTypeListController
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self loadData];
    
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"TypeID":_model.ID,
                           @"pageIndex":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudWithTitle:@"加载中..."];
   self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetTrainList withParameters:pram success:^(id res) {
       [self hideHudVCview];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQTrainListModel *model = [MQTrainListModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [_tableView reloadData];
        _tableView.models = self.models;
    } failure:^(id error) {
        
    }];
}

- (void)initUI
{
    self.navigationItem.title = _model.Name;
    _tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = baseColor;
    [self.view addSubview:_tableView];
    [self.tableView registerCellNibName:[MQTrainListCell class]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQTrainListModel *model = self.models[indexPath.row];
    MQTrainListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQTrainListCell class])];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQTrainListModel *model = self.models[indexPath.row];
    MQTrainDesController *vc = [MQTrainDesController new] ;
    vc.model = model;
    vc.navigationItem.title = @"培训详情";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
