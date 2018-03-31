//
//  MQPostionStyleController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/15.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPostionStyleController.h"
#import "MQHeader.h"
@interface MQPostionStyleController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *rTableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *subModels;
@property (nonatomic, strong) NSIndexPath *indexPrth;
@property (nonatomic, copy) NSString *ParentId;
@property (nonatomic, strong) MQLabelModel *model;
@end

@implementation MQPostionStyleController

- (NSMutableArray *)subModels
{
    if (!_subModels) {
        _subModels = [NSMutableArray array];
    }
    return _subModels;
}

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData:Postion_ID];
    
    [self initUI];
    
}
- (void)initUI
{
    
    self.navigationItem.title = @"职位选择";
    
    UITableView *rTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    rTableView.tag = 101;
    rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rTableView.delegate = self;
    rTableView.dataSource = self;
    rTableView.backgroundColor = baseColor;
    [self.view addSubview:rTableView];
    _rTableView = rTableView;
    [rTableView registerCellName:[MQBaseCell class]];
    
}

- (void)loadData:(NSString *)ParentId
{
    NSDictionary *pram = @{
                           @"ParentId":ParentId,
                           @"Type":@(0),
                           @"NeedQualification":@(1)
                           };
    
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getJobPositionTypeList withParameters:pram success:^(id res) {
        [self hideHudFromNav];
            [(NSArray *)res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MQLabelModel *model = [MQLabelModel mj_objectWithKeyValues:obj];
                [self.subModels addObject:model];
            }];
            [_rTableView reloadData];
            
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.subModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQBaseCell class])];
    MQLabelModel *model = self.subModels[indexPath.row];
    cell.textLabel.font = font(13);
    cell.textLabel.text = model.Name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MQLabelModel *subModel = self.subModels[indexPath.row];
    _modelBlock(subModel,_model);
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
