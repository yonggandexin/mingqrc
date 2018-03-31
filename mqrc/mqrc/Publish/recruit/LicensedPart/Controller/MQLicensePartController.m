//
//  MQKicensePartController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/21.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQLicensePartController.h"
#import "MQHeader.h"
#import "MQCustomField.h"
#import "MQPostionStyleController.h"
#import "MQResaultView.h"
#import "MQPosCerStyleController.h"
#import "MQEqDesController.h"
#import "MQPosCerModel.h"
#import "MQUpdatePartModel.h"
@interface MQLicensePartController ()
<
UITableViewDelegate,
UITableViewDataSource,
DropDelegate,
MQResaultViewDelegate,
AddressPickerViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *placeHolds;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) MQLabelModel *model;
@property (nonatomic, strong) NSArray *cerModels;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) Province *P;
@property (nonatomic, strong) City *C;
@property (nonatomic, strong) Area *A;
@property (nonatomic, strong) Item *Salaryitem;
@property (nonatomic, strong) Item *EducationItem;
@property (nonatomic, strong) MQUpdatePartModel *updateModel;
@end

@implementation MQLicensePartController

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_barH , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (NSMutableArray *)contents
{
    if (!_contents) {
        _contents = [NSMutableArray array];
        for (int i = 0; i<self.titles.count; i++) {
            [_contents addObject:@""];
        }
    }
    return _contents;
}
- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"职业类别",@"证书要求",@"招聘人数",@"薪酬",@"学历",@"工作区域",@"详细地址",@"职位详细描述",@"简历接收邮箱",@"联系电话"];
    }
    return _titles;
}

- (NSArray *)placeHolds
{
    if (!_placeHolds) {
        _placeHolds = @[@"",@"",@"请填写招聘人数",@"",@"",@"",@"请填写详细地址",@"请填写职位详细描述",@"请填写简历接收邮箱",@"请填写联系电话"];
    }
    return _placeHolds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
    if (self.isMine == YES) {
        [self loadUpdateData];
    }
}

- (void)loadUpdateData
{
    
    NSDictionary *pram = @{
                           @"id":_ID
                           };
    [self hudNavWithTitle:@"加载中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetPublishPartJobPositionInfo withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQUpdatePartModel *updateModel = [MQUpdatePartModel mj_objectWithKeyValues:res];
        _updateModel =  updateModel;
        [self reloadUpdateModel];
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}

- (void)reloadUpdateModel
{
    [self.contents replaceObjectAtIndex:0 withObject:_updateModel.JobName];
    
    [_updateModel.JobPositionQualificationIds enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isAdd = YES;
    }];
    _cerModels = _updateModel.JobPositionQualificationIds;
    [self initCerModels];
    
    [self.contents replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%zd",_updateModel.RecruitmentNumber]];
    
    //薪资范围
    _Salaryitem = [Item new];
    _Salaryitem.index = _updateModel.Salary;
    _Salaryitem.Text = SalaryState[_updateModel.Salary];
    [self.contents replaceObjectAtIndex:3 withObject:_Salaryitem.Text];
    //学历要求
    _EducationItem = [Item new];
    _EducationItem.index = _updateModel.RequierEducation;
    _EducationItem.Text = Requirements[_updateModel.RequierEducation];
    [self.contents replaceObjectAtIndex:4 withObject:_EducationItem.Text];
    
    [self sureBtnClickReturnProvince:_updateModel.WorkProvince City:_updateModel.WorkCity Area:_updateModel.WorkArea];
    
    [self.contents replaceObjectAtIndex:6 withObject:_updateModel.WorkAddress];
    
    [self.contents replaceObjectAtIndex:7 withObject:_updateModel.RequireContent];
    
    [self.contents replaceObjectAtIndex:8 withObject:_updateModel.Email];
    [self.contents replaceObjectAtIndex:9 withObject:_updateModel.Mobile];
    
    [_tableView reloadData];
}

- (void)initUI
{
    self.navigationItem.title = @"发布持证兼职";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellName:[MQFrameLableCell class]];
    [tableView registerCellName:[MQFrameFiledCell class]];
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 30, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"发布" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [self.view addSubview:self.pickerView];
    
}

// 在这个方法中，我们就可以通过自定义textField的indexPath属性区分不同行的cell，然后拿到textField.text
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti {
    if([noti.object isKindOfClass:[MQCustomField class]]){
        MQCustomField *textField = noti.object;
        NSString *text = textField.text;
        NSInteger row =textField.indexPath.row;
        [self.contents replaceObjectAtIndex:row withObject:text];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 0 || indexPath.row == 1||indexPath.row ==3||indexPath.row == 4||indexPath.row == 5||indexPath.row == 7) {
        cellID = NSStringFromClass([MQFrameLableCell class]);
    }else{
        cellID = NSStringFromClass([MQFrameFiledCell class]);
    }

    MQFrameBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.placeStr = self.placeHolds[indexPath.row];
    cell.titleL.text = self.titles[indexPath.row];
    [cell cellIsFirst:indexPath.row == 0];
    if (indexPath.row == 2 || indexPath.row == 9) {
        MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
        filedCell.contentFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1||indexPath.row ==3||indexPath.row == 4||indexPath.row == 5||indexPath.row == 7){
        MQFrameLableCell *lableCell = (MQFrameLableCell *)cell;
        lableCell.contentL.text = [self.contents objectAtIndex:indexPath.row];
    }else{
        MQFrameFiledCell *titleCell = (MQFrameFiledCell *)cell;
        titleCell.contentFiled.indexPath = indexPath;
        titleCell.contentFiled.text = [self.contents objectAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MQPostionStyleController *vc = [MQPostionStyleController new];
        [vc setModelBlock:^(MQLabelModel *model,MQLabelModel *presentModel) {
            _model = model;
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
    if (indexPath.row == 3) {
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:SalaryState andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemSalary;
        [self.view endEditing:YES];
    }
    if (indexPath.row == 4) {
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:Requirements andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemEducation;
        [self.view endEditing:YES];
    }
    if (indexPath.row == 5) {
        [self.pickerView show];
        [self.view endEditing:YES];
    }
   
    if(indexPath.row == 7){
        MQEqDesController *desVC = [MQEqDesController new];
        desVC.title = @"职位详细描述";
        desVC.placeStr = @"至少10个字";
        desVC.desText = [self.contents objectAtIndex:indexPath.row];
        [desVC setTextBlock:^(NSString *text) {
            [self.contents replaceObjectAtIndex:indexPath.row withObject:text];
            [_tableView roloadCell:0 andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:desVC animated:YES];
    }
}

- (void)checkCer
{
    MQResaultView *popV = [MQResaultView show:_cerModels];
    popV.delegate = self;
}

- (void)selectedCer
{
    MQPosCerStyleController *vc = [MQPosCerStyleController new];
    vc.addModels = _cerModels;
    vc.ID = Postion_ID;
    [vc setTypeBlock:^(NSArray *models) {
        _cerModels = models;
        [self initCerModels];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initCerModels{
    if (_cerModels.count>0) {
        [self.contents replaceObjectAtIndex:1 withObject:@"查看已选证书类型"];
    }else{
        [self.contents replaceObjectAtIndex:1 withObject:@"请选择证书类型"];
    }
    [_tableView roloadCell:0 andRow:1];
}


- (void)goCheckAlreadyData
{
    [self selectedCer];
}
- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
    _A = area;
    
    NSString *adressText = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
    if (adressText && adressText.length) {
        [self.contents replaceObjectAtIndex:5 withObject:adressText];
    }
    [_pickerView hide];
    [_tableView roloadCell:0 andRow:5];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}

- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (dropView.dropStyle == ItemSalary) {
        //薪资
        [self.contents replaceObjectAtIndex:3 withObject:item.Text];
        [_tableView roloadCell:0 andRow:3];
        _Salaryitem = item;
    }
    
    if (dropView.dropStyle == ItemEducation) {
        //学历
        [self.contents replaceObjectAtIndex:4 withObject:item.Text];
        [_tableView roloadCell:0 andRow:4];
        _EducationItem = item;
    }
}

- (void)pubBtnClicked
{
  
    if(((NSString *)self.contents[0]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择职位类别"];
        return;
    }
    
    if(_cerModels.count == 0){
        [MBProgressHUD showAutoMessage:@"请选择证书类型"];
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
    
    
    
    if(((NSString *)self.contents[4]).length == 0){
        [MBProgressHUD showAutoMessage:@"请选择工作区域"];
        return;
    }
    
    if(((NSString *)self.contents[6]).length == 0){
        [MBProgressHUD showAutoMessage:@"请填写详细地址"];
        return;
    }
    
    if(((NSString *)self.contents[7]).length == 0){
        [MBProgressHUD showAutoMessage:@"请填写详细描述"];
        return;
    }
    
   
    if(![ValiDateTool validateEmail:((NSString *)self.contents[8])]){
        [MBProgressHUD showAutoMessage:@"请填写正确的邮箱"];
        return;
    }
    
    if(![ValiDateTool checkTelNumber:((NSString *)self.contents[9])]){
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
        urlStr = API_updateJobPositionParttimeQualification;
        ID = _updateModel.ID;
    }else{
        urlStr = API_addJobPositionParttimeQualification;
        ID = @"";
    }
    NSDictionary *pram = @{
                           @"JobName":_contents[0],
                           @"JobPositionQualificationIds":ids,
                           @"RecruitmentNumber":_contents[2],
                           @"Salary":@(_Salaryitem.index),
                           @"WorkAddress":_contents[6],
                           @"RequireContent":_contents[7],
                           @"WorkProvince":@(_P.ID),
                           @"WorkCity":@(_C.ID),
                           @"WorkArea":@(_A.ID),
                           @"Email":_contents[8],
                           @"Mobile":_contents[9],
                           @"RequierEducation":@(_EducationItem.index),
                           @"id":ID
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
@end
