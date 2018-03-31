//
//  MQUserSetController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQUserSetController.h"
#import "MQHeader.h"
@interface MQUserSetController ()

@end

@implementation MQUserSetController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    MQBaseSureBtn *cancelBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 100, SCREEN_WIDTH-20, 45);
    [cancelBtn setTitle:@"退出" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];


}
//注销
- (void)btnClicked:(UIButton *)btn
{
    [MBProgressHUD showMessage:@"加载中" ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_UserLogOut withParameters:nil success:^(id res) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        [MQLoginTool updateModel];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
    }];
}
@end
