//
//  MQHomeController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//
#import "MQAcquisController.h"
#import "MQHeader.h"
#import "MNavigationBar.h"
#import "MQEqHomeController.h"
#import "MQLaBannerModel.h"
#import "MQHomeModel.h"
#import "MQSectionView.h"
#import "MQHomeTypeCell.h"
#import "MQHomeNewCell.h"
#import "MQHomeAdCell.h"
#import "MQHomeSpecilCell.h"
#import "MQHomeServiceCell.h"
#import "MQRecomandCell.h"
#import "MQGuessLikeCell.h"
#import "MQTransferShowController.h"
#import "MQFullShowController.h"
#import "MQPartShowController.h"
#import "MQPreviewResumeVC.h"
#import "MQJobWantedController.h"
#import "MQTrainTypeConyroller.h"
@interface MQEqHomeController ()
<
MNavigationBarDelegate,
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
MQHomeTypeDelegate
>
@property (nonatomic, strong)  MNavigationBar *navBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *sdView;
@property (nonatomic, strong) NSArray *secTitles;
@property (nonatomic, strong) MQHomeModel *model;
@end

@implementation MQEqHomeController
#pragma mark -Lazy

- (NSArray *)secTitles
{
    if (!_secTitles) {
        _secTitles = @[@"",@"本地服务",@"本地特色",@"精选推荐",@"猜你喜欢"];
    }
    return _secTitles;
}

#pragma mark -Staus
#pragma mark -Super
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTestBtn];
   
    [self initTableView];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self loadData];
    }];
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
    //初始化导航栏
    [self addNavBar];
    //轮播图
    [self addSDCycleView];

}
- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"切换端口" forState:UIControlStateNormal];
    btn.titleLabel.font = font(11);
    [btn setTitle:@"2112" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btndimo:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = mainColor;
    btn.center = CGPointMake(SCREEN_WIDTH*0.5, 20);
    btn.bounds = CGRectMake(0, 0, 60, 20);
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
}
- (void)btndimo:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [NetworkHelper shareInstance].isDimo = btn.selected;
}
#pragma mark -Init
- (void)initTableView
{
    CGFloat top = IS_IPHONE_X?44:20;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -top, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    
    [tableView registerCellName:[MQHomeTypeCell class]];
    [tableView registerCellName:[UITableViewCell class]];
    [tableView registerCellNibName:[MQHomeNewCell class]];
//    [tableView registerCellNibName:[MQHomeAdCell class]];
//    [tableView registerCellName:[MQHomeSpecilCell class]];
//    [tableView registerCellNibName:[MQHomeServiceCell class]];
//    [tableView registerCellNibName:[MQRecomandCell class]];
//    [tableView registerCellNibName:[MQGuessLikeCell class]];
}

- (void)addSDCycleView
{
    SDCycleScrollView *sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5) delegate:self placeholderImage:nil];
    _sdView = sdView;
    _tableView.tableHeaderView = sdView;
}

- (void)addNavBar
{
    MNavigationBar *navBar = [MNavigationBar mMavigationBarWithStyle:MNavigationBarStyleHome];
    navBar.delegate =self;
    [self.view addSubview:navBar];
    _navBar = navBar;
}

#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [UIView new];
    }
    MQSectionView *secV = [[NSBundle mainBundle]loadNibNamed:@"MQSectionView" owner:nil options:nil][0];
    secV.titleL.text = @"优质推荐";
    return secV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }else if (indexPath.row == 1){
            return 30;
        }
    }
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    cellID = NSStringFromClass([UITableViewCell class]);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellID = NSStringFromClass([MQHomeTypeCell class]);
        }else if (indexPath.row == 1){
            cellID = NSStringFromClass([MQHomeNewCell class]);
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MQHomeTypeCell *typeCell = (MQHomeTypeCell *)cell;
            typeCell.delegate = self;
            
        }else if (indexPath.row == 1) {
            MQHomeNewCell *newcell= (MQHomeNewCell *)cell;
            newcell.lsNews = _model.LsNews;
        }
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%@", scrollView);
//    [_navBar changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
   
}

#pragma mark -Server
- (void)loadData
{
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetAllDataList withParameters:nil success:^(id res) {
        [_tableView.mj_header endRefreshing];
        MQHomeModel *model = [MQHomeModel mj_objectWithKeyValues:res];
        _model = model;
        [self configSdView];
        [_tableView reloadData];
    } failure:^(id error) {
        [_tableView.mj_header endRefreshing];
    }];
}

- (void)configSdView
{
    NSMutableArray *imgs = [NSMutableArray array];
    [_model.LsBanner enumerateObjectsUsingBlock:^(MQLaBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@",HTTPService,obj.img_url];
        [imgs addObject:imgUrl];
    }];
    _sdView.imageURLStringsGroup = imgs;
}

#pragma mark -MQHomeTypeDelegate
- (void)goToNextFunc:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self.navigationController pushViewController:[MQAcquisController new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[MQTransferShowController new] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[MQPartShowController new] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[MQFullShowController new] animated:YES];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[MQTrainTypeConyroller new] animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
