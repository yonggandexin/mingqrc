//
//  MQIndustyController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQIndustyController.h"
#import "MQHeader.h"
#import "MQIndustyModel.h"
#import "MQEqAcquisController.h"
#import "MQEqTransferController.h"
#import "MQCertificateController.h"
#import "MQPubLicenseFullController.h"
@interface MQIndustyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQIndustyController
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self initUI];
   
}
- (void)initUI
{
    self.navigationItem.title = @"选择行业";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = baseColor;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellName:[MQBaseCell class]];
}

- (void)loadData
{
    [MBProgressHUD showMessage:@"加载中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getSharesIndustryList withParameters:nil success:^(id res) {
        NSArray *arr = [res objectForKey:@"data"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQIndustyModel *model = [MQIndustyModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQBaseCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = font(14);
    MQIndustyModel *model = self.models[indexPath.row];
    [cell isFirst:NO andIsLast:(indexPath.row == _models.count-1)];
    cell.textLabel.text = model.TITLE;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQIndustyModel *model = self.models[indexPath.row];
    if (_eqType == ShareTypeAcquis) {
        //股权收购
        MQEqAcquisController *vc = [MQEqAcquisController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(_eqType == ShareTypeTrans){
        //股权转让
        MQEqTransferController *vc = [MQEqTransferController new];
        vc.stateModel = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (_eqType == ShareTypeSelectedA){
        //筛选证书(股权收购)
        NSNotification *noti = [NSNotification notificationWithName:Selected_Aqcer object:model];
        [MQNotificationCent postNotification:noti];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if (_eqType == ShareTypeSelectedT){
        //筛选证书(股权转让)
        NSNotification *noti = [NSNotification notificationWithName:Selected_Trcer object:model];
        [MQNotificationCent postNotification:noti];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}


@end
