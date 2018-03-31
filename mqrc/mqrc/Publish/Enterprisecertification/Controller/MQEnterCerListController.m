//
//  MQEnterCerListController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/13.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEnterCerListController.h"
#import "MQHeader.h"
#import "MQCheckStateModel.h"
#import "MQEnterCerController.h"
#import "MQEnterCerStateCell.h"
#import "MQEqTransferController.h"
@interface MQEnterCerListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) MQEmptTableView *tableView;
@end

@implementation MQEnterCerListController
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
    
    [self initUI];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_task cancel];
}

- (void)initUI
{
    self.navigationItem.title = @"股权转让企业认证列表";
    
    self.tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = baseColor;
    [self.view addSubview:self.tableView];
    
    CGFloat bottom = IS_IPHONE_X?34:0;
    MQBaseSureBtn *addBrn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    addBrn.frame = CGRectMake(10, SCREEN_HEIGHT-nav_barH-55-bottom, SCREEN_WIDTH-20, 45);
    [addBrn setTitle:@"添加企业认证" forState:UIControlStateNormal];
    [addBrn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBrn];
    [self.tableView registerCellNibName:[MQEnterCerStateCell class]];
}

- (void)loadData
{
    [self showHudWithTitle:@"加载中..."];
    _task =[[NetworkHelper shareInstance]postHttpToServerWithURL:API_getCorporateCertification withParameters:nil success:^(id res) {
        [self hideHudVCview];
        [self.models removeAllObjects];
        [(NSArray *)res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQCheckStateModel *model = [MQCheckStateModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
        self.tableView.models = self.models;
    } failure:^(id error) {
        [self hideHudVCview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)dealloc
{
    [self hideHudVCview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MQEnterCerStateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQEnterCerStateCell class])];
    MQCheckStateModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQCheckStateModel *model = self.models[indexPath.row];
    if(model.STATE_CHECK == 1){
        //去发布股权转让
        MQEqTransferController *tranVC = [MQEqTransferController new];
        tranVC.stateModel = model;
        [self.navigationController pushViewController:tranVC animated:YES];
    }else if(model.STATE_CHECK == -1){
        //企业认证失败不能发布
        MQEnterCerController *vc = [MQEnterCerController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [MBProgressHUD showAutoMessage:@"企业认证审核未完成，请耐心等待"];
    }
}

- (void)btnClicked:(UIButton *)btn
{

    MQEnterCerController *vc = [MQEnterCerController new];
    vc.model = [MQCheckStateModel new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
