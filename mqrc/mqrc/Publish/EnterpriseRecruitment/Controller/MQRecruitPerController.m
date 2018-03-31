//
//  MQRecruitPerController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRecruitPerController.h"
#import "MQEqTitleCell.h"
#import "MQHeader.h"
#import "MQCustomField.h"
#import "MQHandleFooterView.h"
#import "MQCustomField.h"
#import "MQResaultController.h"
@interface MQRecruitPerController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *places;
/**
 姓名
 */
@property (nonatomic, strong) MQCustomField *nameT;
/**
 身份证号码
 */
@property (nonatomic, strong) MQCustomField *numT;

@property (nonatomic, strong) MQHandleFooterView *footV;
@end

@implementation MQRecruitPerController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人身份认证";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    MQHandleFooterView *footV = [[NSBundle mainBundle]loadNibNamed:@"MQHandleFooterView" owner:nil options:nil][0];
    tableView.tableFooterView = footV;
    footV.superVC = self;
    [footV.finishBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _footV = footV;
    
    [tableView registerCellNibName:[MQEqTitleCell class]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MQEqTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQEqTitleCell class])];
    
    cell.titleL.text = self.titles[indexPath.row];
    if (indexPath.row == 0) {
        _nameT = cell.contentT;
    }else{
        _numT = cell.contentT;
    }
    cell.contentT.placeholder = self.places[indexPath.row];
    
    return cell;
}

- (void)btnClicked:(UIButton *)btn
{
    
    if (_nameT.text.length==0||_nameT.text == nil) {
        [MBProgressHUD showAutoMessage:@"请输入姓名"];
        return;
    }
    
    if (_numT.text.length != 18) {
        [MBProgressHUD showAutoMessage:@"您输入的身份证号格式不对"];
        return;
    }
    
    if(!_footV.imgUrl){
        [MBProgressHUD showAutoMessage:@"请上传手持身份证照片"];
        return;
    }

    NSDictionary *pram = @{
                           @"ImgUrl":_footV.imgUrl,
                           @"Name":_nameT.text,
                           @"IdCardNumber":_numT.text
                           };
    
    [self hudNavWithTitle:@"保存中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_AddUserAuthentication withParameters:pram success:^(id res) {
        [self.navigationController popViewControllerAnimated:YES];
        [self hideHudFromNav];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view  animated:YES];
        [self hideHudFromNav];
    }];
    
}

- (NSArray *)titles
{
    return @[@"姓名",@"身份证号码"];
}
-(NSArray *)places
{
    return @[@"请输入姓名",@"请输入18位身份证号"];
}
@end
