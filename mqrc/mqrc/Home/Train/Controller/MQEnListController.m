//
//  MQEnListController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQEnListController.h"
#import "MQHeader.h"
#import "MQCustomField.h"
#import "MQTrainListModel.h"
@interface MQEnListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *placeStr;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cardID;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *phoneNum;

@property (nonatomic, copy) NSString *adress;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MQEnListController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"报名";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, footView.height-40, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;

    [tableView registerCellName:[MQFrameFiledCell class]];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];

}

// 在这个方法中，我们就可以通过自定义textField的indexPath属性区分不同行的cell，然后拿到textField.text
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti {

    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQFrameFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQFrameFiledCell class])];
    cell.titleL.text = self.titles[indexPath.row];
    cell.placeStr = self.placeStr[indexPath.row];
    [cell cellIsFirst:indexPath.row == 0];
    switch (indexPath.row) {
        case 0:
            _name = cell.contentFiled.text;
            break;
        case 1:
            _cardID = cell.contentFiled.text;
            break;
        case 2:
            _email = cell.contentFiled.text;
            break;
        case 3:
            _phoneNum = cell.contentFiled.text;
            break;
        case 4:
            _adress = cell.contentFiled.text;
            break;
        default:
            break;
    }
    return cell;
}

- (void)pubBtnClicked
{
    if (_name.length == 0||_name.length>6) {
        [MBProgressHUD showAutoMessage:@"请填写正确的姓名"];
        return;
    }
    
    if (_cardID.length == 0||_cardID.length>18) {
        [MBProgressHUD showAutoMessage:@"请填写正确的身份证号"];
        return;
    }
    
    if(![ValiDateTool validateEmail:_email]){
        [MBProgressHUD showAutoMessage:@"请填写正确的邮箱"];
        return;
    }
    if(![ValiDateTool checkTelNumber:_phoneNum]){
        [MBProgressHUD showAutoMessage:@"请填写正确的手机号码"];
        return;
    }
    
    if(_adress.length == 0){
        [MBProgressHUD showAutoMessage:@"请填写正确的住址"];
        return;
    }
    
    [self hudNavWithTitle:@"保存中..."];
    NSDictionary *pram = @{
                           @"Name":_name,
                           @"Phone":_phoneNum,
                           @"TrainID":_model.ID,
                           @"IdCard":_cardID,
                           @"Address":_adress,
                           @"Email":_email
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_AddCustomEnter withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQResaultController *vc = [MQResaultController new];
        vc.desStr = @"保存成功";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}

- (NSArray *)titles
{
    return @[@"姓名",@"身份证号码",@"邮箱",@"手机号码",@"住址"];
}

- (NSArray *)placeStr
{
    return @[@"请填写姓名",@"请填写身份证号码",@"请填写邮箱",@"请填写手机号码",@"请填写住址"];
}
@end
