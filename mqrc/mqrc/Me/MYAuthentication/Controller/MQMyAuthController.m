//
//  MQMyAuthController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/11.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMyAuthController.h"
#import "MQHeader.h"
#import "MQRecruitCerCell.h"
#import "MQEnterCerListController.h"
#import "MQRecruitCerController.h"
@interface MQMyAuthController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@end

@implementation MQMyAuthController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.title = @"我的企业认证";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    
    [tableView registerCellNibName:[MQRecruitCerCell class]];
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
        headView.textLabel.text = @"股权转让企业认证";
    }else{
        headView.textLabel.text = @"招聘企业认证";
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
        cell.titleL.text = @"股权转让";
        cell.imgV.image = [UIImage imageNamed:@"EquityTransfer"];
    }else{
        cell.titleL.text = @"持证招聘";
        cell.imgV.image = [UIImage imageNamed:@"LicensedRecruitment"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[MQEnterCerListController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[MQRecruitCerController new] animated:YES];
    }
}
@end
