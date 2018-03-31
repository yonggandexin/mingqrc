//
//  MQRegisterController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRegisterController.h"
#import "MQHeader.h"
@interface MQRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneT;
@property (weak, nonatomic) IBOutlet UITextField *codeT;
@property (weak, nonatomic) IBOutlet UITextField *passWordOne;
@property (weak, nonatomic) IBOutlet UITextField *surePassword;
- (IBAction)backLoginClicked:(id)sender;
- (IBAction)closeEyeClicke:(id)sender;
- (IBAction)registerBtnClicked:(id)sender;
- (IBAction)getCodeClicked:(id)sender;
- (IBAction)dissbtnClicked:(id)sender;

@end

@implementation MQRegisterController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    CGFloat toTop = IS_IPHONE_X?24:0;
    _top.constant = toTop+20;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_desType == FindLoginPwd) {
        [_registerBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    }else if (_desType == registerUser){
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
    
}

- (IBAction)backLoginClicked:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)closeEyeClicke:(UIButton *)sender {
    sender.selected = !sender.selected;
    _surePassword.secureTextEntry = !sender.selected;
}

//获取动态码
- (IBAction)getCodeClicked:(UIButton *)sender {
    
    if (![ValiDateTool checkTelNumber:_phoneT.text]) {
        [MBProgressHUD showAutoMessage:@"手机号码格式不正确"];
        return;
    }
    sender.enabled = NO;
    UserPasswordType type = 0;
    if (_desType == registerUser) {
        type = UserPasswordType_Register;
    }else if(_desType == FindLoginPwd){
        type = UserPasswordType_Findpwd;
    }
    NSDictionary *pram = @{
                           @"mobile":_phoneT.text,
                           @"type":@(type)
                           };
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
//注册事件
- (IBAction)registerBtnClicked:(id)sender {
    
    if (![ValiDateTool checkTelNumber:_phoneT.text]) {
        [MBProgressHUD showAutoMessage:@"手机号码格式不正确"];
        return;
    }
    
    if (_codeT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入动态码"];
        return;
    }
    
    if (![ValiDateTool checkPassword:_passWordOne.text]) {
        [MBProgressHUD showAutoMessage:@"密码需为字母加数字且长度位于6到18位"];
        return;
    }
    
    if(![_surePassword.text isEqualToString:_passWordOne.text]){
        [MBProgressHUD showAutoMessage:@"确认密码输入有误"];
        return;
    }
    
    NSDictionary *pram = @{
                           @"mobile":_phoneT.text,
                           @"smsCode":_codeT.text,
                           @"password":[_passWordOne.text SHA1],
                           @"rePassword":[_surePassword.text SHA1]
                           };
    NSString *message = nil;
    NSString *apiStr = nil;
    if (_desType == registerUser) {
        message = @"注册成功";
        apiStr = API_registerUser;
    }else if(_desType == FindLoginPwd){
        message = @"找回密码成功";
        apiStr = API_FindLoginPwd;
    }
    [MBProgressHUD showMessage:@"加载中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:apiStr withParameters:pram success:^(id res) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [MBProgressHUD showAutoMessage:message];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
    
    
}
- (void)dealloc
{
    
}

- (IBAction)dissbtnClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
