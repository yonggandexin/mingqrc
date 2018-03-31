//
//  MQEqAcquisDesController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/30.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEqAcquisDesController.h"
#import "MQHeader.h"
#import "MQEqAcqDes.h"
#import "MQEqModel.h"
#import "MQAcqDesModel.h"
#import "MQGuessLikeCell.h"
#import "MQCommdHeader.h"
#import "MQFullBottomView.h"
#import "MQShareTool.h"
#import "MQEqAcquisController.h"
@interface MQEqAcquisDesController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) MQEqAcqDes *desView;
@property (nonatomic, strong) NSMutableArray *comModels;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *ContactDic;
@property (nonatomic, strong) MQFullBottomView *bottomView;
@property (nonatomic, strong) MQAcqDesModel *desModel;
@end

@implementation MQEqAcquisDesController

- (NSMutableArray *)comModels
{
    if (!_comModels) {
        _comModels = [NSMutableArray array];
    }
    return _comModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self initUI];
   
    
}

- (void)initUI
{
    if (self.isMine == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMyTakeOver)];
    }
    self.navigationItem.title = @"股权收购详情";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStyleGrouped];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellNibName:[MQGuessLikeCell class]];
    
    CGFloat iphonex_bottom = IS_IPHONE_X?24:0;
    _bottomView = [[MQFullBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-nav_barH-iphonex_bottom, SCREEN_WIDTH, 50)];
    _bottomView.ID = _model.ID;
    _bottomView.itemStyle = SHARE_TAKEOVER;
    [_bottomView.resumeBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    __weak typeof(self)weakSelf = self;
    [_bottomView setToDoBlock:^{
        //拨打电话
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[weakSelf.ContactDic objectForKey:@"Phone"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
        });
    }];
    [_bottomView setShareBlock:^{
        [MQShareTool shareContent:@"名企" andTitle:weakSelf.desModel.Title andUrl:weakSelf.desModel.ShareUrl];
    }];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    MQEqAcqDes *desView = [[NSBundle mainBundle]loadNibNamed:@"MQEqAcqDes" owner:nil options:nil][0];
    tableView.tableHeaderView = desView;
    _desView = desView;
}

- (void)editMyTakeOver
{
    MQEqAcquisController *vc = [MQEqAcquisController new];
    vc.model = _desModel;
    vc.isMine = self.isMine;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData
{
    [self loadHeadData];
    
    [self loadRecommonData];
}

- (void)loadHeadData
{
    NSDictionary *pram = @{
                           @"id":_model.ID
                           };
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_getSharesTakeOverInfo withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQAcqDesModel *model = [MQAcqDesModel mj_objectWithKeyValues:[res objectForKey:@"TakeOverInfo"]];
        _desView.model = model;
        _bottomView.IsCollect = model.IsCollect;
        _ContactDic = [res objectForKey:@"Contact"];
        _desModel = model;
    } failure:^(id error) {
        [self hideHudFromNav];
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
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetRecommendSharesTakeOverList withParameters:pram success:^(NSArray *res) {
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQEqModel *model = [MQEqModel mj_objectWithKeyValues:obj];
            [self.comModels addObject:model];
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
    return self.comModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQEqModel *eqModel = self.comModels[indexPath.row];
    MQEqAcquisDesController *vc = [MQEqAcquisDesController new];
    vc.model = eqModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQGuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQGuessLikeCell class])];
    cell.eqModel = self.comModels[indexPath.row];
    return cell;
}
@end
