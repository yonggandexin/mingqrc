//
//  MQPartShowController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPartShowController.h"
#import "MQPartShowCell.h"
#import "MQHeader.h"
#import "MQPartModel.h"
#import "MQPartDesController.h"
#import "MQEmptTableView.h"
#import "MQRegionController.h"
@interface MQPartShowController ()
<
UITableViewDelegate,
UITableViewDataSource,
DropDelegate
>
@property (nonatomic, assign) BOOL isScreen;
@property (nonatomic, weak) MQEmptTableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *selectedModels;
@property (nonatomic, assign) NSInteger Education;
@property (nonatomic, assign) NSInteger Salary;
@property (nonatomic, copy) NSString *provinceName;
@end
static NSInteger _currentPage;
static NSInteger _screenPage;

@implementation MQPartShowController
- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

-(NSMutableArray *)selectedModels
{
    if(!_selectedModels){
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self loadInitLoadData];
    
    [self setupRefresh];
}

- (void)initUI
{
    [MQNotificationCent addObserver:self selector:@selector(changeRegion:) name:Selected_city object:nil];
    
    [MQNotificationCent addObserver:self selector:@selector(nowLoacation:) name:Now_Province object:nil];
    self.navigationItem.title = @"持证兼职";
    MQEmptTableView *tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH-36) style:UITableViewStylePlain];
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerCellNibName:[MQPartShowCell class]];
    _tableView = tableView;
}

//首次请求数据
- (void)loadInitLoadData
{
    //首次进入请求参数初始化
    _currentPage = 1;
    _provinceName = @"";
    _Education = 0;
    _Salary = 0;
    [self loadData];
}

//上拉加载（筛选和非筛选）
- (void)setupRefresh
{
    //上拉加载
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.isScreen == YES) {
            //条件筛选请求数据
            [weakSelf loadScreenModels];
        }else{
            //非条件筛选请求数据
            [weakSelf loadData];
        }
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
}

/**
 重写父类的方法
 */
- (void)clickWithBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            [self selectedRegion];
        }
            break;
        case 1:
        {
            [self selectedRequirements];
        }
            break;
        case 2:
        {
            [self selecTedsalary];
        }
            break;
        default:
            break;
    }
}

- (void)dealloc{
    [MQNotificationCent removeObserver:self];
}

//地区选择
- (void)selectedRegion {
    
    MQRegionController *regionVC = [MQRegionController new];
    regionVC.region = ShareTypeAcquis;
    MQPresentNavController *nv = [[MQPresentNavController alloc]initWithRootViewController:regionVC];
    [self presentViewController:nv animated:YES completion:nil];
}

//地区筛选通知
- (void)changeRegion:(NSNotification *)noti
{
    Province *pro =(Province *) noti.object;
    if (pro.ID == 0) {
        //全部地区
        _provinceName = @"";
         [self.btns[0] setTitle:@"全国" forState:UIControlStateNormal];
    }else{
        _provinceName = pro.Name;
         [self.btns[0] setTitle:_provinceName forState:UIControlStateNormal];
    }
   
    [self isAllPram];
}
//学历选择
- (void)selectedRequirements {
    NSMutableArray *titles = [NSMutableArray array];
    [titles addObject:@"所有"];
    [titles addObjectsFromArray:Requirements];
    MQDropTypeView *dropV = [MQDropTypeView showWithItems:titles andDirection:YES];
    dropV.dropStyle = ItemEducation;
    dropV.btn = self.btns[1];
    dropV.delegate = self;
}

//薪酬选择
- (void)selecTedsalary {
    NSMutableArray *titles = [NSMutableArray array];
    [titles addObject:@"所有"];
    [titles addObjectsFromArray:SalaryState];
    MQDropTypeView *dropV = [MQDropTypeView showWithItems:titles andDirection:YES];
    dropV.dropStyle = ItemSalary;
    dropV.btn = self.btns[2];
    dropV.delegate = self;
}

- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (dropView.dropStyle == ItemEducation) {
        _Education = item.index;
        if (item.index == 0) {
            [dropView.btn setTitle:@"学历" forState:UIControlStateNormal];
        }
    }
    
    if (dropView.dropStyle == ItemSalary) {
        _Salary = item.index;
        if (item.index == 0) {
            [dropView.btn setTitle:@"薪酬" forState:UIControlStateNormal];
        }
    }
    [self isAllPram];
}

//判断是否为帅选条件
- (void)isAllPram{
    
    if ([_provinceName isEqualToString:@""]&&_Salary == 0&&_Education == 0) {
        [self loadData];
    }else{
        _screenPage = 1;
        [self.selectedModels removeAllObjects];
        [self loadScreenModels];
    }
}

- (void)nowLoacation:(NSNotification *)noti
{
    _provinceName = (NSString *)noti.object;
    [self.btns[0] setTitle:_provinceName forState:UIControlStateNormal];
    [self isAllPram];
}

- (void)loadData
{
    NSDictionary *pram = @{
                           @"Province":@"",
                           @"Education":@(0),
                           @"Salary":@(0),
                           @"pageIndex":@(_currentPage),
                           @"pageSize":@(10)
                           };
    _isScreen = NO;
    [self showHudWithTitle:@"加载中..."];
   self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetPartJobPositionList withParameters:pram success:^(id res) {
        [self hideHudVCview];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQPartModel *model = [MQPartModel mj_objectWithKeyValues:obj];
            [self.models addObject:model];
        }];
        [self.tableView reloadData];
        
        //若无数据则设置背景图片
        self.tableView.models = self.models;
        [self.tableView.mj_footer endRefreshing];
        if (((NSArray *)res).count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        _currentPage++;
    } failure:^(id error) {
        [self hideHudVCview];
    }];
    
}

- (void)loadScreenModels
{
    NSDictionary *pram = @{
                           @"Province":_provinceName,
                           @"Education":@(_Education),
                           @"Salary":@(_Salary),
                           @"pageIndex":@(_screenPage),
                           @"pageSize":@(10)
                           };
    [self showHudWithTitle:@"加载中..."];
    _isScreen = YES;
   self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetPartJobPositionList withParameters:pram success:^(id res) {
        [self hideHudVCview];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQPartModel *model = [MQPartModel mj_objectWithKeyValues:obj];
            [self.selectedModels addObject:model];
        }];
        [_tableView reloadData];
        //若无数据则设置背景图片
        self.tableView.models = self.selectedModels;
        [self.tableView.mj_footer endRefreshing];
        if (((NSArray *)res).count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        _screenPage++;
    } failure:^(id error) {
        [self.tableView.mj_footer endRefreshing];
        [self hideHudVCview];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isScreen == YES) {
        return self.selectedModels.count;
    }
    return self.models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQPartShowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQPartShowCell class])];
    MQPartModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQPartDesController *vc = [MQPartDesController new];
    MQPartModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)titles
{
    return @[@"地区",@"学历",@"薪酬"];
}
@end
