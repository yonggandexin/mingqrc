//
//  MQPhoneLoginController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPhoneLoginController.h"
#import "MQRegisterController.h"
#import "MQHeader.h"
#import "MQLoginModel.h"
@interface MQPhoneLoginController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;
- (IBAction)dismisClicked:(id)sender;
- (IBAction)registerClicked:(id)sender;
- (IBAction)getCode:(id)sender;
- (IBAction)Login:(id)sender;
- (IBAction)userNameLogin:(id)sender;
- (IBAction)closeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneT;
@property (weak, nonatomic) IBOutlet UITextField *pswT;

@end

@implementation MQPhoneLoginController
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
        _phoneT.text = phone;
        [_pswT becomeFirstResponder];
    }else{
        [_phoneT becomeFirstResponder];
    }

}


- (IBAction)dismisClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClicked:(id)sender {
    
    [self.navigationController pushViewController:[MQRegisterController new] animated:YES];
}
- (IBAction)getCode:(UIButton *)sender {
    if (![ValiDateTool checkTelNumber:_phoneT.text]) {
        [MBProgressHUD showAutoMessage:@"手机号码格式不正确"];
        return;
    }
    
    NSDictionary *pram = @{
                           @"mobile":_phoneT.text,
                           @"type":@(UserPasswordType_Login)
                           };
    sender.enabled = NO;
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_sendSmsCode withParameters:pram success:^(id res) {
        [self addTimeer];
    } failure:^(id error) {
        sender.enabled = YES;
    }];
}
- (void)addTimeer
{
    __weak typeof(self) weakSelf = self;
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.authCodeBtn.enabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.authCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                weakSelf.authCodeBtn.enabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//18314437955
- (IBAction)Login:(id)sender {
    if (![ValiDateTool checkTelNumber:_phoneT.text]) {
        [MBProgressHUD showAutoMessage:@"手机号码格式不正确"];
        return;
    }
    
    if (_pswT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入动态码"];
        return;
    }
    
    [MBProgressHUD showMessage:@"登录中..." ToView:self.view];
    NSDictionary *pram = @{
                           @"userName":_phoneT.text,
                           @"password":_pswT.text,
                           @"type":@(1)
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

- (IBAction)userNameLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)closeClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    _pswT.secureTextEntry = !sender.selected;
    
}
@end
