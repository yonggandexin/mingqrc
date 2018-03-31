//
//  MQPartDesController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPartDesController.h"
#import "MQHeader.h"
#import "MQFullHeaderView.h"
#import "MQPartModel.h"
#import "MQPartDesModel.h"
#import "MQFullBottomView.h"
#import "MQShareTool.h"
#import "MQLicensePartController.h"
@interface MQPartDesController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) MQFullBottomView *bottomV ;
@property (nonatomic, strong) MQFullHeaderView *desView;
@property (nonatomic, strong) MQPartDesModel *desModel;
@end

@implementation MQPartDesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"职位详情";
    [self initUI];
    [self loadData];
    
}

- (void)initUI
{
    if (self.isMine == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMyPart)];
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
    MQFullHeaderView *desView = [[NSBundle mainBundle]loadNibNamed:@"MQFullHeaderView" owner:nil options:nil][0];
    tableView.tableHeaderView = desView;
    _desView = desView;
    
    CGFloat iphonex_bottom = IS_IPHONE_X?24:0;
    _bottomV = [[MQFullBottomView alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT-nav_barH-50-iphonex_bottom, SCREEN_WIDTH, 50)];
    [_bottomV.resumeBtn setTitle:@"投递简历" forState:UIControlStateNormal];
    _bottomV.ID = _model.ID;
    _bottomV.itemStyle = PART_JOB_POSITON;
    __weak typeof(self) weakSelf = self;
    [_bottomV setToDoBlock:^{
        MQLoginModel *model = [MQLoginTool shareInstance].model;
        if (model.IsResume == YES) {
            [weakSelf DeliveryResume];
        }else{
            [MQAlertTool goToCreatResume:weakSelf];
        }
    }];
    
    [_bottomV setShareBlock:^{
        
        [MQShareTool shareContent:@"名企" andTitle:weakSelf.desModel.Title andUrl:weakSelf.desModel.ShareUrl];
        
    }];
    [self.view addSubview:_bottomV];
}

//投递简历
- (void)DeliveryResume
{
    NSDictionary *pram = @{
                           @"PositionID":_desView.partModel.ID
                           };
    [self hudNavWithTitle:@"投递中..."];
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_UserDeliveryResume withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        [_bottomV.resumeBtn setTitle:@"已投递" forState:UIControlStateNormal];
        _bottomV.resumeBtn.enabled = NO;
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"id":_model.ID
                           };
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetPartPositionInfo withParameters:pram success:^(id res) {
        [self hideHudFromNav];
       
        NSDictionary *dic = [res objectForKey:@"PositionInfo"];
        MQPartDesModel *model = [MQPartDesModel mj_objectWithKeyValues:dic];
        if (model.IsSend == YES) {
            [_bottomV.resumeBtn setTitle:@"已投递" forState:UIControlStateNormal];
            _bottomV.resumeBtn.enabled = NO;
        }
        _bottomV.IsCollect = model.IsCollect;
        _desView.partModel = model;
        _desModel = model;
    } failure:^(id error) {
        [self hideHudFromNav];
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)editMyPart
{
    MQLicensePartController *vc = [MQLicensePartController new];
    vc.isMine = self.isMine;
    vc.ID = _model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
