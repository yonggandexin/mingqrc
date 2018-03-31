//
//  MQAcquisController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAcquisController.h"
#import "MQRegionController.h"
#import "MQHeader.h"
#import "City.h"
#import "MQGuessLikeModel.h"
#import "MQEqModel.h"
#import "MQGuessLikeCell.h"
#import "MQEmptTableView.h"
#import "MQEqAcquisDesController.h"
#import "MQSelectedIndustyController.h"
#import "MQIndustyModel.h"
#import "MQSelectBtn.h"
#import "MQEqModel.h"
@interface MQAcquisController ()
<
UITableViewDelegate,
UITableViewDataSource
>
- (IBAction)selecTedAddress:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *adressBtn;
@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, copy) NSString *province;
@property (nonatomic, strong) NSMutableArray *selectedModels;
@property (nonatomic, assign) BOOL isScreen;
@property (nonatomic, strong) MQEmptTableView *tableView;
@property (nonatomic, strong) NSMutableArray *boxModels;


@end
static NSInteger _screenPage;
@implementation MQAcquisController
#pragma mark -Lazy
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

#pragma mark -Init
- (void)initUI
{
    
    self.tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-36-nav_barH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = baseColor;
    self.tableView.estimatedRowHeight = 200.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"股权收购";
    [self.view addSubview:self.tableView];
    [self.tableView registerCellNibName:[MQGuessLikeCell class]];
    
    [MQNotificationCent addObserver:self selector:@selector(changeRegion:) name:Selected_city object:nil];
    [MQNotificationCent addObserver:self selector:@selector(getNowProvince:) name:Now_Province object:nil];
}

#pragma mark -Staus
//收到点击当前位置的通知
- (void)getNowProvince:(NSNotification *)noti
{
    _province = (NSString *)noti.object;
    [_adressBtn setTitle:_province forState:UIControlStateNormal];
    [self isAllPram];
    
}
#pragma mark -Super
- (void)viewDidLoad {
    [super viewDidLoad];
    //参数初始化
    _province = [LocaltionInstance shareInstance].province;
    [_adressBtn setTitle:_province forState:UIControlStateNormal];
    [self initUI];
    [self setupRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MQDropTypeView dismissDropView];
}
- (void)dealloc
{
    [MQNotificationCent removeObserver:self];
}

- (IBAction)selecTedAddress:(id)sender
{
    MQRegionController *regionVC = [MQRegionController new];
    regionVC.region = ShareTypeAcquis;
    MQPresentNavController *nv = [[MQPresentNavController alloc]initWithRootViewController:regionVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (void)setupRefresh
{
     [self isAllPram];
    //上拉加载
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.isScreen == YES) {
            //条件筛选请求数据
            [weakSelf loadScreenModels];
        }
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
}


#pragma mark -Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isScreen == YES) {
        return self.selectedModels.count;
    }
    return self.models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQGuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQGuessLikeCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MQEqModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    cell.eqModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQEqModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    
    MQEqAcquisDesController *acVC = [MQEqAcquisDesController new];
    acVC.model = model;
    [self.navigationController pushViewController:acVC animated:YES];
    
}

//地区筛选通知
- (void)changeRegion:(NSNotification *)noti
{
    Province *pro =(Province *) noti.object;
    [_adressBtn setTitle:pro.Name forState:UIControlStateNormal];
    _province = pro.Name;
    [self isAllPram];
}

- (void)isAllPram{

    _screenPage = 1;
    [self.selectedModels removeAllObjects];
    [self loadScreenModels];
}

#pragma mark -Server

//筛选
- (void)loadScreenModels
{
    
    NSDictionary *pram = @{
                           @"province":_province,
                           @"pageIndex":@(_screenPage),
                           @"pageSize":@(10)
                           };
    if (_screenPage == 1) {
        //首次进入的时候添加遮盖
        [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    }
    _isScreen = YES;
    self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getSharesTakeOverList withParameters:pram success:^(NSArray *res) {
        XLOG(@"筛选请求成功");
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        _screenPage++;
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQEqModel *model = [MQEqModel mj_objectWithKeyValues:obj];
            [self.selectedModels addObject:model];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (res.count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
         self.tableView.models = self.selectedModels;
    } failure:^(id error) {
        XLOG(@"筛选请求失败");
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSString *)imgName
{

    return @"nothing";
    
}

-(NSString *)desStr
{
    return @"没有符合条件的结果,换个条件试试！";
}
@end

@implementation AdressBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.y = 7;
    self.imageView.width = 20;
    self.imageView.height = 20;
    
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame)+10;
}

@end
