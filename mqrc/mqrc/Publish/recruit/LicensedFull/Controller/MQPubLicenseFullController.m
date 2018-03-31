//
//  MQPubLicenseFullController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/15.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPubLicenseFullController.h"
#import "MQHeader.h"
#import "MQeqLightsCell.h"
#import "MQCustomField.h"
#import "MQPostionStyleController.h"
#import "MQCustomLable.h"
#import "MQPosCerStyleController.h"
#import "MQResaultView.h"
#import "MQDropTypeView.h"
#import "MQJobWelfareModel.h"
#import "MQEqDesController.h"
#import "AddressPickerView.h"
#import "MQPosCerModel.h"
#import "MQUpdateFullModel.h"
@interface MQPubLicenseFullController ()
<
UITableViewDataSource,
UITableViewDelegate,
MQResaultViewDelegate,
DropDelegate,
AddressPickerViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) MQLabelModel *model;//职位类别
@property (nonatomic, strong) MQLabelModel *presentModel;
@property (nonatomic, strong) NSArray *cerModels;
@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) Province *P;
@property (nonatomic, strong) City *C;
@property (nonatomic, strong) Area *A;
@property (nonatomic, strong) Item *Salaryitem;
@property (nonatomic, strong) Item *Requirementsitem;
@property (nonatomic, strong) Item *Experienceitem;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *placeHolds;
@property (nonatomic, strong) MQUpdateFullModel *updateModel;
@end

@implementation MQPubLicenseFullController


- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_barH , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray arrayWithCapacity:11];
        for (int i = 0; i < 12; i++) {
            if (i == 4) {
                [_contents addObject:[NSArray array]];
            }else{
                [_contents addObject:@""];
            }
        }
    }
    return _contents;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self loadData];
    
    if(self.isMine == YES){
        [self loadUpdateData];
    }
    
    [self.view addSubview:self.pickerView];
}

- (void)loadUpdateData
{
    NSDictionary *pram = @{
                           @"id":_ID
                           };
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetPublishFullJobPositionInfo withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQUpdateFullModel *updateModel = [MQUpdateFullModel mj_objectWithKeyValues:res];
        _updateModel = updateModel;
        [self loadUpdateModle];
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}


- (void)loadUpdateModle{
    
    [self.contents replaceObjectAtIndex:0 withObject:_updateModel.JobName];
    [_updateModel.JobPositionQualificationIds enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isAdd = YES;
    }];
    _cerModels = _updateModel.JobPositionQualificationIds;
    [self loadCerData];
    [self.contents replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%zd",_updateModel.RecruitmentNumber]];
   
    //薪资范围
    _Salaryitem = [Item new];
    _Salaryitem.index = _updateModel.Salary;
    _Salaryitem.Text = SalaryState[_updateModel.Salary];
    [self.contents replaceObjectAtIndex:3 withObject:_Salaryitem.Text];
    //学历要求
    _Requirementsitem = [Item new];
    _Requirementsitem.index = _updateModel.RequierEducation;
    _Requirementsitem.Text = Requirements[_updateModel.RequierEducation];
    [self.contents replaceObjectAtIndex:5 withObject:_Requirementsitem.Text];
    //工作年限
    _Experienceitem = [Item new];
    _Experienceitem.index = _updateModel.RequireWorkexperience;
    _Experienceitem.Text = Experience[_updateModel.RequireWorkexperience];
    [self.contents replaceObjectAtIndex:6 withObject:_Experienceitem.Text];
    
    [self.contents replaceObjectAtIndex:7 withObject:_updateModel.RequireContent];
    
    [self sureBtnClickReturnProvince:_updateModel.WorkProvince City:_updateModel.WorkCity Area:_updateModel.WorkArea];
    
    [self.contents replaceObjectAtIndex:9 withObject:_updateModel.WorkAddress];
    
    [self.contents replaceObjectAtIndex:10 withObject:_updateModel.Email];
    
    [self.contents replaceObjectAtIndex:11 withObject:_updateModel.Mobile];
  
    [_tableView reloadData];
    
}

- (void)loadData{
    
   self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getJobWelfare withParameters:nil success:^(id res) {
        NSMutableArray *highs = [NSMutableArray array];
        [res enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQJobWelfareModel *model = [MQJobWelfareModel mj_objectWithKeyValues:obj];
            [highs addObject:model];
        }];
        [self.contents replaceObjectAtIndex:4 withObject:highs];
        [_tableView roloadCell:0 andRow:4];
    } failure:^(id error) {
    }];
}

- (void)initUI
{
    self.navigationItem.title = @"发布持证全职";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerCellName:[MQFrameLableCell class]];
    [tableView registerCellName:[MQFrameFiledCell class]];
    [tableView registerCellName:[MQeqLightsCell class]];
    
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 30, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"发布" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

// 在这个方法中，我们就可以通过自定义textField的indexPath属性区分不同行的cell，然后拿到textField.text
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti {
    if ([noti.object isKindOfClass:[MQCustomField class]]) {
        MQCustomField *textField = noti.object;
        NSString *text = textField.text;
        NSInteger row =textField.indexPath.row;
        [self.contents replaceObjectAtIndex:row withObject:text];
    } 
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2||indexPath.row == 9||indexPath.row == 10||indexPath.row == 11){
        MQFrameFiledCell *titleCell = (MQFrameFiledCell *)cell;
        titleCell.contentFiled.indexPath = indexPath;
        titleCell.contentFiled.text = [self.contents objectAtIndex:indexPath.row];
        titleCell.contentFiled.placeholder = self.placeHolds[indexPath.row];
        titleCell.titleL.text = self.titles[indexPath.row];
        [titleCell cellIsFirst:indexPath.row == 0];
    }else if (indexPath.row!=4){
        MQFrameLableCell *iqCell =(MQFrameLableCell *)cell;
        iqCell.contentL.text = [self.contents objectAtIndex:indexPath.row];
        iqCell.titleL.text = self.titles[indexPath.row];
         [iqCell cellIsFirst:indexPath.row == 0];
    }else if(indexPath.row == 4){
        MQeqLightsCell *lightCell = (MQeqLightsCell *)cell;
        lightCell.obWelfares = [self.contents objectAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 100;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 4){
        cellID = NSStringFromClass([MQeqLightsCell class]);
    }else if (indexPath.row == 2||indexPath.row == 9||indexPath.row == 10||indexPath.row == 11){
        cellID = NSStringFromClass([MQFrameFiledCell class]);
    } else{
        cellID = NSStringFromClass([MQFrameLableCell class]);
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (indexPath.row == 4) {
        MQeqLightsCell *lightCell = (MQeqLightsCell *)cell;
        lightCell.lable.text = @"职位福利";
    }
    if (indexPath.row == 2 || indexPath.row == 11) {
        MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
        filedCell.contentFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MQPostionStyleController *vc = [MQPostionStyleController new];
        [vc setModelBlock:^(MQLabelModel *model,MQLabelModel *presentModel) {
            _model = model;
            _presentModel = presentModel;
            [self.contents replaceObjectAtIndex:indexPath.row withObject:model.Name];
            [_tableView roloadCell:0 andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        if (_cerModels.count>0) {
            [self checkCer];
        }else{
            [self selectedCer];
        }
    }
    
    if(indexPath.row == 3){
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:SalaryState andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemSalary;
        [self.view endEditing:YES];
    }
    if(indexPath.row == 5){
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:Requirements andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemRequirements;
        [self.view endEditing:YES];
    }
    if(indexPath.row == 6){
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:Experience andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemExperience;
        [self.view endEditing:YES];
    }
    if (indexPath.row ==7) {
        MQEqDesController *desVC = [MQEqDesController new];
        desVC.title = @"任职要求";
        desVC.placeStr = @"至少10个字";
        desVC.desText = [self.contents objectAtIndex:indexPath.row];
        [desVC setTextBlock:^(NSString *text) {
            [self.contents replaceObjectAtIndex:indexPath.row withObject:text];
            [_tableView roloadCell:0 andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:desVC animated:YES];
    }
    
    
    if (indexPath.row == 8) {
        [self.pickerView show];
        [self.view endEditing:YES];
    }
}

- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
    _A = area;
    
    NSString *adressText = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
    if (adressText && adressText.length) {
        [self.contents replaceObjectAtIndex:8 withObject:adressText];
    }
    [_pickerView hide];
    [_tableView roloadCell:0 andRow:8];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}
- (void)goCheckAlreadyData
{
    [self selectedCer];
}

- (void)selectedCer
{
    MQPosCerStyleController *vc = [MQPosCerStyleController new];
    vc.addModels = _cerModels;
    vc.ID = Postion_ID;
    [vc setTypeBlock:^(NSArray *models) {
        _cerModels = models;
        [self loadCerData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadCerData
{
    if (_cerModels.count>0) {
        [self.contents replaceObjectAtIndex:1 withObject:@"查看已选证书类型"];
    }else{
        [self.contents replaceObjectAtIndex:1 withObject:@"请选择证书类型"];
    }
    [_tableView roloadCell:0 andRow:1];
    
}

- (void)checkCer
{
    MQResaultView *popV = [MQResaultView show:_cerModels];
    popV.delegate = self;
}

- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (dropView.dropStyle == ItemSalary) {
        //薪资
        [self.contents replaceObjectAtIndex:3 withObject:item.Text];
        [_tableView roloadCell:0 andRow:3];
        _Salaryitem = item;
    }else if (dropView.dropStyle == ItemRequirements){
        //学历
        [self.contents replaceObjectAtIndex:5 withObject:item.Text];
        [_tableView roloadCell:0 andRow:5];
        _Requirementsitem = item;
    }else if (dropView.dropStyle == ItemExperience){
        //工作年限
        [self.contents replaceObjectAtIndex:6 withObject:item.Text];
        [_tableView roloadCell:0 andRow:6];
        _Experienceitem = item;
    }
}
- (void)pubBtnClicked
{
    
    
    if(((NSString *)self.contents[0]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择职位类别"];
        return;
    }
    
    if(_cerModels.count == 0){
        [MBProgressHUD showAutoMessage:@"请选择证书要求"];
        return;
    }
    
    NSString *num = self.contents[2];
    if(!num || [num integerValue] == 0){
        [MBProgressHUD showAutoMessage:@"请填写招聘人数"];
        return;
    }
    if(((NSString *)self.contents[3]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择薪酬"];
        return;
    }
    
    NSMutableArray *lights = [NSMutableArray array];
    [((NSArray *)self.contents[4]) enumerateObjectsUsingBlock:^(MQJobWelfareModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelscted == YES) {
            [lights addObject:obj.ID];
        }
    }];
    if(lights.count == 0){
        [MBProgressHUD showAutoMessage:@"选一项只为福利吧"];
        return;
    }
    
    if(((NSString *)self.contents[5]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择学历要求"];
        return;
    }
    
    if(((NSString *)self.contents[6]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择工作年限"];
        return;
    }
    
    if(((NSString *)self.contents[7]).length == 0){
        [MBProgressHUD showAutoMessage:@"请填写任职要求"];
        return;
    }
    
    if(((NSString *)self.contents[8]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择工作区域"];
        return;
    }
    
    if(((NSString *)self.contents[9]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择详细地址"];
        return;
    }
    
    if(![ValiDateTool validateEmail:((NSString *)self.contents[10])]){
        [MBProgressHUD showAutoMessage:@"请填写正确的邮箱"];
        return;
    }
    
    if(![ValiDateTool checkTelNumber:((NSString *)self.contents[11])]){
        [MBProgressHUD showAutoMessage:@"请填写正确的手机号码"];
        return;
    }
    
    NSMutableArray *ids = [NSMutableArray array];
    [_cerModels enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ids addObject:obj.ID];
    }];
    
    NSString *urlStr = nil;
    NSString *ID = nil;
    if (self.isMine == YES) {
        urlStr = API_updateJobPositionOrdinaryQualification;
        ID = _updateModel.ID;
    }else{
        urlStr = API_addJobPositionOrdinaryQualification;
        ID = @"";
    }
    NSDictionary *pram = @{
                           @"JobName":self.contents[0],
                           @"JobPositionQualificationIds":ids,
                           @"RecruitmentNumber":_contents[2],
                           @"Salary":@(_Salaryitem.index),
                           @"JobWelfareIds":lights,
                           @"RequierEducation":@(_Requirementsitem.index),
                           @"RequireWorkexperience":@(_Experienceitem.index),
                           @"RequireContent":_contents[7],
                           @"WorkProvince":@(_P.ID),
                           @"WorkCity":@(_C.ID),
                           @"WorkArea":@(_A.ID),
                           @"WorkAddress":_contents[9],
                           @"Email":_contents[10],
                           @"Mobile":_contents[11],
                           @"ID":ID
                           };
  
    [self hudNavWithTitle:@"发布中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:urlStr withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQResaultController *vc = [MQResaultController new];
        vc.desStr = @"发布成功";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}

- (NSArray *)titles
{
    return @[@"职位类别",@"证书要求",@"招聘人数",@"薪酬",@"",@"学历要求",@"工作年限",@"任职要求",@"工作区域",@"详细地址",@"简历接收邮箱",@"手机号码"];
}

- (NSArray *)placeHolds
{
    return @[@"",@"",@"请输入招聘人数",@"",@"",@"",@"",@"",@"",@"请填写详细地址",@"请输入正确的邮箱",@"请输入正确的手机号码"];
}
@end
