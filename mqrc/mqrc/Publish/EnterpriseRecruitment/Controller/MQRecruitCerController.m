//
//  MQRecruitCerController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRecruitCerController.h"
#import "MQRecruitCerCell.h"
#import "MQHeader.h"
#import "MQRecruitComController.h"
#import "MQRecruitPerController.h"
@interface MQRecruitCerController ()
<
UITableViewDelegate,
UITableViewDataSource
>


@property (nonatomic, copy) NSString *CompanyAuth;
@property (nonatomic, assign) NSInteger com;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *UserAuth;
@property (nonatomic, assign) NSInteger user;
@end

@implementation MQRecruitCerController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"招聘企业认证";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.tableFooterView = [UIView new];
    
    [tableView registerCellNibName:[MQRecruitCerCell class]];
}

- (void)loadData
{
    [self hudNavWithTitle:@"请求中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetJobCheckStatus withParameters:nil success:^(id res) {
        [self hideHudFromNav];
        
        //判断企业认证状态
        [self updateState:(NSDictionary *)res];
        [self.tableView reloadData];
    } failure:^(id error) {
        [self.navigationController popViewControllerAnimated:YES];
        [self hideHudFromNav];
    }];
}

- (void)updateState:(NSDictionary *)dic
{
    _com = [[dic objectForKey:@"CompanyAuth"] integerValue];
    _user =[[dic objectForKey:@"UserAuth"] integerValue];
    if (_com == 0) {
        _CompanyAuth = @"去认证";
    }else if (_com == 1){
        _CompanyAuth = @"待审核";
    }else if (_com == 2){
        _CompanyAuth = @"审核失败";
    }else if (_com == 3){
        _CompanyAuth = @"审核成功";
    }
    
    if (_user == 0) {
        _UserAuth = @"去认证";
    }else if (_user == 1){
        _UserAuth = @"待审核";
    }else if (_user == 2){
        _UserAuth = @"审核失败";
    }else if (_user == 3){
        _UserAuth = @"审核成功";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc]init];
    headView.contentView.backgroundColor = baseColor;
    if (section == 0) {
        headView.textLabel.text = @"企业资质认证";
    }else{
        headView.textLabel.text = @"个人资质认证";
    }
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQRecruitCerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQRecruitCerCell class])];
    if (indexPath.section == 0) {
        cell.titleL.text = @"企业认证";
        cell.stateL.text = _CompanyAuth;
        cell.imgV.image = [UIImage imageNamed:@"firm_recruit"];
    }else{
        cell.titleL.text = @"身份证认证";
        cell.stateL.text = _UserAuth;
        cell.imgV.image = [UIImage imageNamed:@"job_wanted"];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQRecruitComController *VC = [MQRecruitComController new];
    VC.state = _com;
    
    if (indexPath.section == 0) {
        if (_com == 0) {
            [self.navigationController pushViewController:VC animated:YES];
        }else if (_com == 1){
            [MBProgressHUD showAutoMessage:@"请耐心等待审核"];
        }else if (_com == 2){
             [self.navigationController pushViewController:VC animated:YES];
        }else if (_com == 3){
        
            [MBProgressHUD showAutoMessage:@"企业认证已完成"];
        }
    }
    
    if (indexPath.section == 1) {
        
        if (_com!=3) {
            [MBProgressHUD showAutoMessage:@"企业认证未完成"];
            return;
        }
        
        if (_user == 0) {
            [self.navigationController pushViewController:[MQRecruitPerController new] animated:YES];
        }else if (_user == 1){
            [MBProgressHUD showAutoMessage:@"请耐心等待审核"];
        }else if (_user == 2){
            [self.navigationController pushViewController:[MQRecruitPerController new] animated:YES];
        }else if (_user == 3){
            [MBProgressHUD showAutoMessage:@"身份证认证已完成，您可以发布招聘信息了"];
        }
    }
}
@end
