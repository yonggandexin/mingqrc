//
//  MQTrainDesController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTrainDesController.h"
#import "MQTrainDesHeaderV.h"
#import "MQHeader.h"
#import "MQTrainListModel.h"
#import "MQTrainInfoModel.h"
#import "MQTrainBottomV.h"
#import "MQEnListController.h"
@interface MQTrainDesController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) MQTrainDesHeaderV *headerV;
@end

@implementation MQTrainDesController

- (void)viewDidLoad {
    [super viewDidLoad];

   

    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.bounces = NO;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = baseColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    

    MQTrainDesHeaderV *headerV =[self creatWithXIB:@"MQTrainDesHeaderV"];
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
    tableView.tableHeaderView = headerV;
    _headerV = headerV;
    
    MQTrainBottomV *bottomV = [self creatWithXIB:@"MQTrainBottomV"];
    CGFloat toBottom = IS_IPHONE_X?24:0;
    bottomV.frame = CGRectMake(0, SCREEN_HEIGHT-50-nav_barH-toBottom, SCREEN_WIDTH, 50);
    [bottomV setShareBlock:^{
        //分享
        
    }];
    
    [bottomV setShareCommon:^{
        //立即报名
        MQEnListController *vc = [MQEnListController new];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [tableView addSubview:bottomV];
    
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}



- (void)loadData
{
    NSDictionary *pram =@{
                          @"id":_model.ID
                          };
    [self showHudWithTitle:@"加载中..."];
    self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetCustomTrainInfo withParameters:pram success:^(id res) {
        MQTrainInfoModel *model = [MQTrainInfoModel mj_objectWithKeyValues:res];
        _headerV.model = model;
        [self hideHudVCview];
    } failure:^(id error) {
         [self hideHudVCview];
    }];
}

@end
