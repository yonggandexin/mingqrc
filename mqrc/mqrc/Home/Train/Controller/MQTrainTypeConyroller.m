//
//  MQTrainTypeConyroller.m
//  mqrc
//
//  Created by 朱波 on 2018/1/6.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTrainTypeConyroller.h"
#import "MQHeader.h"
#import "MQTypeListController.h"
@interface MQTrainTypeConyroller ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSMutableArray *typeModels;
@property (nonatomic, strong) NSMutableArray *subModels;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) MQLabelModel *model;
@end

@implementation MQTrainTypeConyroller
- (NSMutableArray *)typeModels
{
    if (!_typeModels) {
        _typeModels = [NSMutableArray array];
    }
    return _typeModels;
}

- (NSMutableArray *)subModels
{
    if (!_subModels) {
        _subModels = [NSMutableArray array];
    }
    return _subModels;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"培训类型";
    [self initUI];
    
    [self loadData:@""];
       

}

- (void)initUI
{
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.tag = 100;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    [self.view addSubview:_leftTableView];
    [_leftTableView registerCellName:[MQBaseCell class]];
    
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 0,SCREEN_WIDTH-100 , SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    _rightTableView.tag = 101;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    [self.view addSubview:_rightTableView];
    [_rightTableView registerCellName:[MQBaseCell class]];
    
}

- (void)loadData:(NSString *)pramID
{
    NSDictionary *pram = @{
                           @"ParentID":pramID
                           };
    [self showHudWithTitle:@"加载中..."];
    self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetCustomTrainTypeList withParameters:pram success:^(id res) {
        [self hideHudVCview];
        if (pramID.length>0) {
            [self.subModels removeAllObjects];
            [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MQLabelModel *model = [MQLabelModel mj_objectWithKeyValues:obj];
                [self.subModels addObject:model];
            }];
            [_rightTableView reloadData];
        }else{
            [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MQLabelModel *model = [MQLabelModel mj_objectWithKeyValues:obj];
                [self.typeModels addObject:model];
            }];
            [_leftTableView reloadData];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            MQLabelModel *model = self.typeModels[0];
            [self loadData:model.ID];
        }
    } failure:^(id error) {
         [self hideHudVCview];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return self.typeModels.count;
    }
    return self.subModels.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQBaseCell class])];
    if (tableView.tag == 100) {
        MQLabelModel *model = self.typeModels[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = font(14);
        cell.textLabel.text = model.Name;
    }else if (tableView.tag == 101){
        cell.contentView.backgroundColor = COLOR(217, 217, 217);
        MQLabelModel *model = self.subModels[indexPath.row];
        cell.textLabel.font = font(13);
        cell.textLabel.text = model.Name;
    }
    [cell isFirst:NO andIsLast:indexPath.row == self.typeModels.count-1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        if (indexPath == _indexPath) {
            return;
        }
        MQLabelModel *model = self.typeModels[indexPath.row];
        [self loadData:model.ID];
        _indexPath = indexPath;
    }else if (tableView.tag == 101){
        MQLabelModel *model = self.subModels[indexPath.row];
        MQTypeListController *vc = [MQTypeListController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
