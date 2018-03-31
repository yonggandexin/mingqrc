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
#import "MQRecomandCell.h"
#import "MQGuessLikeCell.h"
#import "MQTransferShowController.h"
#import "MQFullShowController.h"
#import "MQPartShowController.h"
#import "MQPreviewResumeVC.h"
#import "MQJobWantedController.h"
#import "MQTrainTypeConyroller.h"
#import "MQNewsController.h"
#import "MQPartShowCell.h"
#import "MQTransferDesController.h"
#import "MQPartDesController.h"
#import "MQDIYHeader.h"
#import "MQWebViewController.h"
#import "MQNewModel.h"
#import "MQLsBannerView.h"
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
@property (nonatomic, strong) MQLsBannerView *sdView;
@property (nonatomic, strong) MQHomeModel *model;
@property (nonatomic, assign) recommonStyle clickStyle;
@property (nonatomic, strong) MQSectionView *secV;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation MQEqHomeController
#pragma mark -Lazy
- (MQSectionView *)secV
{
    if (!_secV) {
        _secV =  [[NSBundle mainBundle]loadNibNamed:@"MQSectionView" owner:nil options:nil][0];
    }
    return _secV;
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
    _clickStyle = transferStyle;
#ifdef DEBUG
    [self addTestBtn];
#else
    
#endif
    [self initTableView];
    
    _tableView.mj_header = [MQDIYHeader headerWithRefreshingBlock:^{
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
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UILabel *bottom = [UILabel new];
    bottom.text = @"然后就没有了~";
    bottom.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    bottom.textAlignment = NSTextAlignmentCenter;
    bottom.textColor = [UIColor grayColor];
    bottom.font = font(13);
    tableView.tableFooterView = bottom;
    
    _tableView = tableView;
    
    [tableView registerCellName:[MQHomeTypeCell class]];
    [tableView registerCellName:[MQHomeNewCell class]];
    [tableView registerCellNibName:[MQRecomandCell class]];
    [tableView registerCellNibName:[MQGuessLikeCell class]];
    [tableView registerCellNibName:[MQPartShowCell class]];
}

- (void)addSDCycleView
{
    MQLsBannerView *sdView = [[MQLsBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5)];
    [sdView setBannerClick:^(MQLaBannerModel *model) {
        MQWebViewController *webVC = [MQWebViewController new];
        webVC.Url = model.Url;
        [self.navigationController pushViewController:webVC animated:YES];
    }];
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
    [self.secV setSelectedBlock:^(recommonStyle style) {
        _clickStyle = style;
        [tableView reloadSectionWithIndex:1];
    }];
    return self.secV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 70;
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
        }else{
            return 95;
        }
    }else{
        if (_clickStyle == transferStyle) {
            return 100;
        }else{
            return 75;
        }
    }
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
        if (_clickStyle == transferStyle) {
           return _model.ShareTransfers.count;
        }else{
            return _model.PartTimePositions.count;
        }
    }
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
        }else{
            cellID = NSStringFromClass([MQRecomandCell class]);
        }
    }else{
        if (_clickStyle == transferStyle) {

            cellID = NSStringFromClass([MQGuessLikeCell class]);
            
        }else{
            cellID = NSStringFromClass([MQPartShowCell class]);
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
            [newcell setNewsClick:^(MQNewModel *model) {
                MQWebViewController *webVC = [MQWebViewController new];
                webVC.Url = model.Url;
                webVC.title = model.Title;
                [self.navigationController pushViewController:webVC animated:YES];
            }];
        }else{
            MQRecomandCell *comCell = (MQRecomandCell *)cell;
            comCell.superVC = self;
            if (_model) {
                comCell.MiddleAdvert = _model.MiddleAdvert;
            }
        }
            
    }else{
        if (_clickStyle == transferStyle) {
            MQGuessLikeCell *guessCell = (MQGuessLikeCell *)cell;
            guessCell.transModel = _model.ShareTransfers[indexPath.row];
        }else{
            MQPartShowCell *partCell = (MQPartShowCell *)cell;
            partCell.model = _model.PartTimePositions[indexPath.row];
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        if (_clickStyle == transferStyle) {
            MQTranShowModel *transModel = _model.ShareTransfers[indexPath.row];
            MQTransferDesController *transferVC = [MQTransferDesController new];
            transferVC.model = transModel;
            [self.navigationController pushViewController:transferVC animated:YES];
        }else{
            MQPartModel *model = _model.PartTimePositions[indexPath.row];
            MQPartDesController *vc = [MQPartDesController new];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    [_navBar changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
   
}

#pragma mark -Server
- (void)loadData
{
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetAllDataList withParameters:nil success:^(id res) {
        [_tableView.mj_header endRefreshing];
        MQHomeModel *model = [MQHomeModel mj_objectWithKeyValues:res];
        _model = model;
        _sdView.LsBanner = _model.LsBanner;
        [_tableView reloadData];
    } failure:^(id error) {
        [_tableView.mj_header endRefreshing];
    }];
}


- (void)scanlMoreNews
{
    [self.navigationController pushViewController:[MQNewsController new] animated:YES];
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
