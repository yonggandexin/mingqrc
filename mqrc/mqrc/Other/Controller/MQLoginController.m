//
//  MQLoginController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQLoginController.h"
#import "MQHeader.h"
#import "MQLoginModel.h"
#import "MQLoginTool.h"
@interface MQLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumT;
@property (weak, nonatomic) IBOutlet UITextField *psdT;
- (IBAction)viewoffClicked:(id)sender;
- (IBAction)loginClicked:(id)sender;
- (IBAction)disBtnClicked:(id)sender;

@end

@implementation MQLoginController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    _phoneNumT.text = model.MOBILE;
}



- (IBAction)viewoffClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _psdT.secureTextEntry = !sender.selected;
}

- (IBAction)loginClicked:(UIButton *)sender {
    
    if (![ValiDateTool checkTelNumber:_phoneNumT.text]) {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_psdT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"密码不能为空"];
        return;
    }
    [MBProgressHUD showMessage:@"登陆中..." ToView:self.view];
    NSDictionary *pram = @{
                           @"userName":_phoneNumT.text,
                           @"password":_psdT.text
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_login withParameters:pram success:^(id res) {
        [MBProgressHUD hideHUDForView:self.view];
        MQLoginModel *model = [MQLoginModel mj_objectWithKeyValues:res];
        [MQLoginTool shareInstance].model = model;
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    

}

- (IBAction)disBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
