//
//  MQTransferShowController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTransferShowController.h"
#import "MQHeader.h"
#import "MQEmptTableView.h"
#import "MQTranShowModel.h"
#import "MQGuessLikeCell.h"
#import "MQRegionController.h"
#import "City.h"
#import "MQSelectBtn.h"
#import "MQSelectedIndustyController.h"
#import "MQIndustyModel.h"
#import "MQTransferDesController.h"

@interface MQTransferShowController ()
<
UITableViewDelegate,
UITableViewDataSource,
DropDelegate
>
@property (weak, nonatomic) IBOutlet MQSelectBtn *cerBtn;
- (IBAction)regionBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet MQSelectBtn *adressBtn;
@property (nonatomic, strong) MQEmptTableView *tableView;


@property (nonatomic, copy) NSString *minPriceRange;
@property (nonatomic, copy) NSString *maxPriceRange;

@property (nonatomic, copy) NSString *minRegisPriceRange;
@property (nonatomic, copy) NSString *maxRegisPriceRange;

@property (nonatomic, strong) NSMutableArray  *models;
@property (nonatomic, strong) NSMutableArray *selectedModels;
@property (nonatomic, assign) BOOL isScreen;

@property (nonatomic, copy) NSString *province;
@end
static NSInteger _screenPage;
@implementation MQTransferShowController

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
    _province = [LocaltionInstance shareInstance].province;
    
    [self initUI];
    
    [self setupRefresh];
    
    [self registerNoti];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [MQDropTypeView dismissDropView];
}

- (void)dealloc
{
    [MQNotificationCent removeObserver:self];
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
-(void)registerNoti
{
    [MQNotificationCent addObserver:self selector:@selector(selectedRegion:) name:Selected_TransferCity object:nil];
    [MQNotificationCent addObserver:self selector:@selector(getNowProvince:) name:Now_Province object:nil];
}

//收到点击当前位置的通知
- (void)getNowProvince:(NSNotification *)noti
{
    _province = (NSString *)noti.object;
    [_adressBtn setTitle:_province forState:UIControlStateNormal];
    [self isAllPram];
    
}

- (void)initUI
{
    _province = [LocaltionInstance shareInstance].province;
    [_adressBtn setTitle:_province forState:UIControlStateNormal];
    
    self.navigationItem.title = @"股权转让";
    self.tableView = [[MQEmptTableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    self.tableView.backgroundColor = baseColor;
    self.tableView.estimatedRowHeight = 200.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerCellNibName:[MQGuessLikeCell class]];
    
}

- (void)isAllPram{

    _screenPage = 1;
    [self.selectedModels removeAllObjects];
    [self loadScreenModels];
}

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
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getSharesTransferList withParameters:pram success:^(NSArray *res) {
        XLOG(@"筛选请求成功");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _screenPage++;
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQTranShowModel *model = [MQTranShowModel mj_objectWithKeyValues:obj];
            [self.selectedModels addObject:model];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (res.count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.tableView.models = self.selectedModels;
    } failure:^(id error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQGuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQGuessLikeCell class])];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MQTranShowModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    cell.transModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQTranShowModel *model = nil;
    if (_isScreen == YES) {
        model = self.selectedModels[indexPath.row];
    }else{
        model = self.models[indexPath.row];
    }
    
    MQTransferDesController *transferVC = [MQTransferDesController new];
    transferVC.model = model;
    [self.navigationController pushViewController:transferVC animated:YES];
    
}
#pragma mark -Lazy
#pragma mark -Super
#pragma mark -Init
#pragma mark -Server
#pragma mark -Delegate



#pragma mark -Staus
- (IBAction)regionBtnClicked:(id)sender {
    MQRegionController *regionVC = [MQRegionController new];
    regionVC.region = ShareTypeTrans;
    MQPresentNavController *nv = [[MQPresentNavController alloc]initWithRootViewController:regionVC];
    [self presentViewController:nv animated:YES completion:nil];
}


//地区筛选通知
- (void)selectedRegion:(NSNotification *)noti
{
    
    Province *pro =(Province *) noti.object;
    [_adressBtn setTitle:pro.Name forState:UIControlStateNormal];
    _province = pro.Name;
    [self isAllPram];
    
}

#pragma mark -DropDelegate
- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    
    if (item.selectStyle == ItemStyleTransferPrice){
        //转让价格区间
        switch (item.index) {
            case 0:
            {
                _maxPriceRange = _minPriceRange = @"0";
                [item.btn setTitle:@"转让价格" forState:UIControlStateNormal];
                
            }
                break;
            case 1:
            {
                _minPriceRange = @"0";
                _maxPriceRange = @"50";
                
            }
                break;
            case 2:
            {
                _minPriceRange = @"50";
                _maxPriceRange = @"100";
                
            }
                break;
            case 3:
            {
                _minPriceRange = @"100";
                _maxPriceRange = @"10000";
               
            }
                break;
            default:
                break;
        }
    }else if (item.selectStyle == ItemStyleRegisterPrice){
        //注册资金区间
        switch (item.index) {
            case 0:
            {
               _maxRegisPriceRange = _minRegisPriceRange = @"0";
            [item.btn setTitle:@"注册资金" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                _minRegisPriceRange = @"0";
                _maxRegisPriceRange = @"50";
                
            }
                break;
            case 2:
            {
                _minRegisPriceRange = @"50";
                _maxRegisPriceRange = @"100";
                
            }
                break;
            case 3:
            {
                _minRegisPriceRange = @"100";
                _maxRegisPriceRange = @"10000";
                
            }
                break;
            default:
                break;
        }
        
    }
    
    [self isAllPram];
}


@end
