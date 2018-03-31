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
#import "MQRegisterController.h"
#import "MQPhoneLoginController.h"

@interface MQLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumT;
@property (weak, nonatomic) IBOutlet UITextField *psdT;
- (IBAction)codeLogin:(id)sender;
- (IBAction)viewoffClicked:(id)sender;
- (IBAction)loginClicked:(id)sender;
- (IBAction)disBtnClicked:(id)sender;
- (IBAction)registerBtnclicked:(id)sender;
- (IBAction)remerbPassword:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@end

@implementation MQLoginController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    CGFloat top = IS_IPHONE_X?24:0;
    _toTop.constant = 20+top;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:login_userName];
    if (phone) {
        _phoneNumT.text = phone;
        [_psdT becomeFirstResponder];
    }else{
        [_phoneNumT becomeFirstResponder];
    }
}



- (IBAction)codeLogin:(id)sender {
    [self.navigationController pushViewController:[MQPhoneLoginController new] animated:YES];
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
    NSString *psd = [_psdT.text SHA1];
    [MBProgressHUD showMessage:@"登录中..." ToView:self.view];
    NSDictionary *pram = @{
                           @"userName":_phoneNumT.text,
                           @"password":psd
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_login withParameters:pram success:^(id res) {
        [MBProgressHUD hideHUDForView:self.view];
        MQLoginModel *model = [MQLoginModel mj_objectWithKeyValues:res];
        [MQLoginTool shareInstance].model = model;
        [MQLoginTool initAlias];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
}

- (IBAction)disBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerBtnclicked:(id)sender {
    MQRegisterController *registerVC = [MQRegisterController new];
    registerVC.desType = registerUser;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)remerbPassword:(id)sender {
    MQRegisterController *registerVC = [MQRegisterController new];
    registerVC.desType = FindLoginPwd;
    [self.navigationController pushViewController:registerVC animated:YES];
}
@end
