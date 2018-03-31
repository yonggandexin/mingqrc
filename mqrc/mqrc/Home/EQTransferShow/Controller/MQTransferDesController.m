//
//  MQTransferDesController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTransferDesController.h"
#import "MQTranShowModel.h"
#import "MQHeader.h"
#import "MQTransDesModel.h"
#import "MQTrDesHeaderView.h"
#import "MQGuessLikeCell.h"
#import "MQHeader.h"
#import "MQCommdHeader.h"
#import "MQBottomBar.h"
#import "MQFullBottomView.h"
#import "MQShareTool.h"
#import "MQEqTransferController.h"
@interface MQTransferDesController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) MQTrDesHeaderView *header;
@property (nonatomic, strong) UITableView *tableView;
/**
 推荐数据模型
 */
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) MQFullBottomView *bottomView;
@property (nonatomic, strong) NSDictionary *ContactDic;
@property (nonatomic, strong) MQTransDesModel *desModel;
@end

@implementation MQTransferDesController

-(NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"股权转让详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];

    
    [self loadData];

    [self loadRecommonData];
    
}

- (void)initUI
{
    if (self.isMine == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMyTransfer)];
    }
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerCellNibName:[MQGuessLikeCell class]];
    _tableView = tableView;
    
    MQTrDesHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"MQTrDesHeaderView" owner:nil options:nil][0];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 600);
    tableView.tableHeaderView = header;
    header.superVC = self;
    _header = header;
    CGFloat iphonex_bottom = IS_IPHONE_X?24:0;
    MQFullBottomView *bottomView = [[MQFullBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-nav_barH-iphonex_bottom, SCREEN_WIDTH, 50)];
    [bottomView.resumeBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    bottomView.ID = _model.ID;
    bottomView.itemStyle = SHARE_TRANSFER;
    __weak typeof(self)weakSelf = self;
    [bottomView setToDoBlock:^{
        //拨打电话
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_ContactDic objectForKey:@"Phone"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
        });
    }];
    
    [bottomView setShareBlock:^{
        [MQShareTool shareContent:@"名企" andTitle:weakSelf.desModel.Title andUrl:weakSelf.desModel.ShareUrl];
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"id":_model.ID
                           };
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    
    
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getSharesTransferInfo withParameters:pram success:^(id res) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MQTransDesModel *model = [MQTransDesModel mj_objectWithKeyValues:[res objectForKey:@"Transfer"]];
        _header.model = model;
        _ContactDic = [res objectForKey:@"Contact"];
        _bottomView.IsCollect = model.IsCollect;
        _desModel = model;
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)loadRecommonData
{
    NSDictionary *pram = @{
                           @"id":_model.ID,
                           @"pageIndex":@"1",
                           @"pageSize":@"5"
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetRecomendSharesTransferList withParameters:pram success:^(NSArray *res) {
        
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQTranShowModel *model = [MQTranShowModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [_tableView reloadData];
    } failure:^(id error) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MQCommdHeader *header = [[NSBundle mainBundle]loadNibNamed:@"MQCommdHeader" owner:nil options:nil][0];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    MQTransferDesController *vc = [MQTransferDesController new];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editMyTransfer
{
    MQEqTransferController *vc = [MQEqTransferController new];
    vc.isMine = self.isMine;
    vc.transModel = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
