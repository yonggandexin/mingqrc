//
//  MQJobWantedController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/26.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQJobWantedController.h"
#import "MQHeader.h"
#import "MQPosCerStyleController.h"
#import "MQResaultView.h"
#import "MQPostionStyleController.h"
#import "MQNoAreaPickerView.h"
#import "MQJobPerresumeVC.h"
#import "MQPosCerModel.h"
#import "MQResumeModel.h"
#import "MQHopeAddressModel.h"
@interface MQJobWantedController ()
<
UITableViewDelegate,
UITableViewDataSource,
DropDelegate,
MQResaultViewDelegate,
AddressPickerViewDelegate
>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*contents;
@property (nonatomic, strong) NSArray <MQPosCerModel *>*cerModels;
@property (nonatomic, strong) MQLabelModel *pmodel;
@property (nonatomic, strong) MQNoAreaPickerView *pickerView;
@property (nonatomic, strong) Province *P;
@property (nonatomic, strong) City *C;
//@property (nonatomic, strong) Area *A;
@property (nonatomic, strong) Item *JobItem;
@property (nonatomic, strong) Item *salaryItem;
@end

@implementation MQJobWantedController
- (MQNoAreaPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[MQNoAreaPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_barH , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (NSMutableArray <NSString *>*)contents
{
    if (!_contents) {
        _contents = [NSMutableArray array];
        for (int i = 0; i<self.titles.count; i++) {
            [_contents addObject:@""];
        }
    }
    return _contents;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self isEditingResum];
    
    [self initUI];
    
}

- (void)isEditingResum
{
    if (_model) {
        [self.contents replaceObjectAtIndex:0 withObject:_model.JobType];
        _cerModels = _model.Qualicafitions;
        [self loadCerCell];
        [self.contents replaceObjectAtIndex:2 withObject:_model.Position.Name];
        NSString *city =[NSString stringWithFormat:@"%@ %@",_model.WorkProvince.Name,_model.WorkCity.Name];
        [self.contents replaceObjectAtIndex:3 withObject:city];
        [self.contents replaceObjectAtIndex:4 withObject:SalaryState[_model.Salary]];
        _salaryItem.index = _model.Salary;
        _pmodel = _model.Position;
        _P = _model.WorkProvince;
        _C = _model.WorkCity;
    }
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"创建简历";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellName:[MQFrameLableCell class]];
    
    MQBaseSureBtn *btn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    CGFloat barH = IS_IPHONE_X?88:nav_barH;
    btn.frame = CGRectMake(10, SCREEN_HEIGHT-55-barH, SCREEN_WIDTH-20, 45);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.view addSubview:self.pickerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQFrameLableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQFrameLableCell class])];
    cell.titleL.text = self.titles[indexPath.row];
    cell.contentL.text = self.contents[indexPath.row];
    [cell cellIsFirst:indexPath.row == 0];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //求职类型
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:@[@"全职",@"兼职"] andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemJobWant;
    }
    
    if(indexPath.row == 1){
        //个人证书
        if (_cerModels.count>0) {
            [self checkCer];
        }else{
            [self selectedCer];
        }
    }
    
    if(indexPath.row == 2){
        //期望职位
        MQPostionStyleController *vc = [MQPostionStyleController new];
        [vc setModelBlock:^(MQLabelModel *model,MQLabelModel *presentModel) {
            _pmodel = model;
            [self.contents replaceObjectAtIndex:indexPath.row withObject:model.Name];
            [_tableView roloadCell:0 andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(indexPath.row == 3){
        //期望工作地点
        [self.pickerView show];
        [self.view endEditing:YES];
    }
    
    if (indexPath.row == 4) {
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:SalaryState andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemSalary;
        [self.view endEditing:YES];
    }
}
//修改已选证书
- (void)goCheckAlreadyData
{
    [self selectedCer];
}

//查看已选证书
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
    [vc setTypeBlock:^(NSArray <MQPosCerModel *>*models) {
        _cerModels = models;
        [self loadCerCell];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadCerCell
{
    if (_cerModels.count>0) {
        [self.contents replaceObjectAtIndex:1 withObject:@"查看已选证书类型"];
    }else{
        [self.contents replaceObjectAtIndex:1 withObject:@"请选择证书类型"];
    }
    [_tableView roloadCell:0 andRow:1];
}

- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (dropView.dropStyle == ItemJobWant) {
        _JobItem = item;
        [self.contents replaceObjectAtIndex:0 withObject:item.Text];
        [_tableView roloadCell:0 andRow:0];
    }
    
    if (dropView.dropStyle == ItemSalary) {
        _salaryItem = item;
        [self.contents replaceObjectAtIndex:4 withObject:item.Text];
        [_tableView roloadCell:0 andRow:4];
    }
}

- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
//    _A = area;
    
    NSString *adressText = [NSString stringWithFormat:@"%@ %@",province.Name,city.Name];
    if (adressText && adressText.length) {
        [self.contents replaceObjectAtIndex:3 withObject:adressText];
    }
    [_pickerView hide];
    [_tableView roloadCell:0 andRow:3];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}

- (void)btnClicked:(UIButton *)btn
{
    
    if (self.contents[0].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择求职类型"];
        return;
    }
    
    if (_cerModels.count == 0) {
        [MBProgressHUD showAutoMessage:@"请选择个人证书"];
        return;
    }
    
    if (self.contents[2].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择期望职位"];
        return;
    }
    
    if (self.contents[3].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择期望工作地点"];
        return;
    }
    
    if (self.contents[4].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择期望薪酬"];
        return;
    }
    
    NSMutableArray *IDs = [NSMutableArray array];
    [_cerModels enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [IDs addObject:obj.ID];
    }];
    
    MQJobPerresumeVC *vc = [MQJobPerresumeVC new];
    NSMutableArray *pramArr = [NSMutableArray array];
    [pramArr addObjectsFromArray:self.contents];
    [pramArr replaceObjectAtIndex:2 withObject:_pmodel.ID];
    [pramArr replaceObjectAtIndex:1 withObject:IDs];
    [pramArr replaceObjectAtIndex:4 withObject:@(_salaryItem.index)];
    [pramArr removeObjectAtIndex:3];
    [pramArr addObject:@(_P.ID)];
    [pramArr addObject:@(_C.ID)];
    
    vc.lastContents = pramArr;
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)titles
{
    return @[@"求职类型",@"个人证书",@"期望职位",@"期望工作地点",@"期望薪酬"];
}


@end
