//
//  MQMeController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQMeController.h"
#import "MQHeader.h"
#import "MQMeHeaderView.h"
#import "MQUserSetController.h"
#import "MQMeFooterView.h"
#import "MQMyCollectController.h"
#import "MQMyTransferController.h"
#import "MQMtTransferVC.h"
#import "MQMyPubTakeOverVC.h"
#import "MQMineRecruitController.h"
#import "MQMyAuthController.h"
#import "MQMeAdView.h"
#define kHEIGHT SCREEN_WIDTH*0.5
@interface MQMeController ()
<
UITableViewDelegate,
UITableViewDataSource,
MQFootDelegate,
TZImagePickerControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation MQMeController
#pragma mark -Lazy

#pragma mark -Init
#pragma mark -Server
#pragma mark -Delegate
#pragma mark -Staus

#pragma mark -Super
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
  
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = baseColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    [_tableView setContentOffset:CGPointMake(0, -kHEIGHT) animated:NO];
    _tableView.bouncesZoom = NO;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];
    
    imageView.image = [UIImage imageNamed:@"Personal background map"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 101;
    imageView.clipsToBounds = YES;
    [_tableView addSubview:imageView];
    
    MQMeHeaderView *headerV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MQMeHeaderView class]) owner:nil options:nil][0];
    headerV.superVC = self;
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    if (model) {
       headerV.model = model;
    }
    headerV.frame = imageView.frame;
    [headerV.setBtn addTarget:self action:@selector(setUserControler) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:headerV];
    
    MQMeFooterView *footV = [[MQMeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(SCREEN_WIDTH/3)*2) ];
    footV.delegate = self;
    _tableView.tableFooterView = footV;
    
    MQMeAdView *bottomV = [self creatWithXIB:@"MQMeAdView"];
    bottomV.frame = CGRectMake(0,(SCREEN_WIDTH/3)*2, SCREEN_WIDTH, 100);
    [_tableView addSubview:bottomV];
    
}
//设置
- (void)setUserControler
{
    if(![MQLoginTool shareInstance].model){
         [MQLoginTool presentLogin];
        return;
    }
    [self.navigationController pushViewController:[MQUserSetController new] animated:YES];
}

- (void)clickWithIndex:(NSInteger)index
{
    
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    if (!model) {
        [MQLoginTool presentLogin];
        return;
    }
    switch (index) {
        case 0:
        {
            [self.navigationController pushViewController:[MQMyCollectController new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[MQMyPubTakeOverVC new] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[MQMtTransferVC new] animated:YES];
        }
            break;
        case 3:
        {
            MQMineRecruitController *vc = [MQMineRecruitController new];
            vc.topTitle = @"我的招聘";
            vc.vcType = JobWantedType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            MQMineRecruitController *VC = [MQMineRecruitController new];
            VC.topTitle = @"我的求职";
            VC.vcType = recuitType;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 5:
        {
            MQMyAuthController *VC = [MQMyAuthController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -kHEIGHT) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
}


@end
