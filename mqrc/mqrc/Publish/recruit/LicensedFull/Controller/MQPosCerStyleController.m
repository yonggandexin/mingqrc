//
//  MQPosCerStyleController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/16.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPosCerStyleController.h"
#import "MQHeader.h"
#import "MQEqCerCell.h"
#import "MQPosCerModel.h"
@interface MQPosCerStyleController ()<MQEqCerCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MQPosCerStyleController
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"证书类型";
    
   
    [self loadData];
    
    [self initUI];

   
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    _tableView = tableView;
    [_tableView registerCellNibName:[MQEqCerCell class]];

    
    MQBaseSureBtn *btn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, SCREEN_HEIGHT-55-nav_barH, SCREEN_WIDTH-20, 45);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)loadData
{
    NSDictionary *pram = @{
                           @"id":_ID
                           };
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getJobQualificationList withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQPosCerModel *model = [MQPosCerModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        
        if (_addModels.count>0) {
            [self.models enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [_addModels enumerateObjectsUsingBlock:^(MQPosCerModel *_Nonnull addModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([model.ID isEqualToString:addModel.ID]) {
                        model.isAdd = YES;
                    }
                }];
            }];
        }
        
        [self.tableView reloadData];
        XLOG(@"%@",res);
    } failure:^(id error) {
        [self hideHudFromNav];
        
    }];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQEqCerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQEqCerCell class])];
    cell.delegate = self;
    MQPosCerModel *model =self.models[indexPath.row];
    cell.posSerModel = model;
    return cell;
}

- (void)reloadAddData
{
    [self.tableView reloadData];
}

- (void)btnClicked
{
    NSMutableArray *addModels = [NSMutableArray array];
    [self.models enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isAdd == YES) {
            [addModels addObject:obj];
        }
    }];
    _typeBlock(addModels);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
