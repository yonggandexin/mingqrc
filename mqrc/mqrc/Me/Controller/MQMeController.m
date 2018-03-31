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
#import "MQMeBaseCell.h"
#import "MQUserSetController.h"
#define kHEIGHT SCREEN_WIDTH*0.5
@interface MQMeController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imgs;

@end

@implementation MQMeController
#pragma mark -Lazy
- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"我的收购",@"我的转让",@"我的招聘",@"我的求职",@"企业认证",@"反馈"];
    }
    return _titles;
}

- (NSArray *)imgs
{
    if (!_imgs) {
        _imgs = @[@"person_acquis",@"person_trans",@"person_recruit",@"person_job_wanted",@"firm_identify",@"fankui"];
    }
    return _imgs;
}
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


    [_tableView registerCellNibName:[MQMeBaseCell class]];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];
    
    imageView.image = [UIImage imageNamed:@"Personal background map"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 101;
    imageView.clipsToBounds = YES;
    [_tableView addSubview:imageView];
    
    
    MQMeHeaderView *headerV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MQMeHeaderView class]) owner:nil options:nil][0];
    headerV.superVC = self;
    headerV.frame = imageView.frame;
    [headerV.setBtn addTarget:self action:@selector(setUserControler) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:headerV];


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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQMeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQMeBaseCell class])];
    cell.img.image = [UIImage imageNamed:self.imgs[indexPath.row]];
    cell.titleL.text = self.titles[indexPath.row];
    return cell;
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
