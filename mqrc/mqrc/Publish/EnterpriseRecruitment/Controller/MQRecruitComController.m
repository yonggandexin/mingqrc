//
//  MQRecruitComController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRecruitComController.h"
#import "MQHeader.h"
#import "MQPubHeaderView.h"
#import "MQEqTitleCell.h"
#import "MQIqSelectedCell.h"
#import "AddressPickerView.h"
#import "MQCustomField.h"
#import "MQCustomLable.h"
#import "MQEqDesController.h"
#import "MQResaultController.h"
#import "MQCerLocationCell.h"
#import "MQAddCerController.h"
#import "MQSubCerModel.h"
@interface MQRecruitComController ()
<
UITableViewDelegate,
UITableViewDataSource,
AddressPickerViewDelegate,
DropDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) MQPubHeaderView *headerV;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) Province *P;

@property (nonatomic, strong) City *C;

@property (nonatomic, strong) Area *A;

/**
 注册号
 */
@property (nonatomic, copy) MQCustomField *registerT;
/**
 企业名称
 */
@property (nonatomic, copy) MQCustomField *companyNameT;
/**
 企业所在地
 */
@property (nonatomic, copy) NSString *adress;
/**
 详细地址
 */
@property (nonatomic, copy) NSString *desAdd;
/**
 法人代表
 */
@property (nonatomic, strong) MQCustomField *representativeT;
/**
 企业规模
 */
@property (nonatomic, strong) Item *scale;
/**
 企业性质
 */
@property (nonatomic, strong) Item *Nature;
/**
 企业介绍
 */
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, strong) NSArray *models;
@end

@implementation MQRecruitComController
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"企业资质认证";

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 30, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;
    _tableView = tableView;
    
    
    MQPubHeaderView *headerV = [[NSBundle mainBundle]loadNibNamed:@"MQPubHeaderView" owner:nil options:nil][0];
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7);
//    headerV.imgUrl = _model.IMG_URL;
    headerV.vc = self;
    tableView.tableHeaderView = headerV;
    _headerV = headerV;

    [tableView registerCellNibName:[MQEqTitleCell class]];
    [tableView registerCellNibName:[MQIqSelectedCell class]];
    [tableView registerCellName:[MQCerLocationCell class]];
    [self.view addSubview:self.pickerView];
    
    [MQNotificationCent addObserver:self selector:@selector(relodDesAddress:) name:SureAddres_des object:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4) {
        cellID = NSStringFromClass([MQEqTitleCell class]);
    }else if(indexPath.row == 3){
        cellID = NSStringFromClass([MQCerLocationCell class]);
    }else{
        cellID = NSStringFromClass([MQIqSelectedCell class]);
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    switch (indexPath.row) {
        case 0:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入注册号";
            _registerT = titleCell.contentT;
        }
            break;
        case 1:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入企业名称";
            _companyNameT = titleCell.contentT;
        }
            break;
        case 2:
        {
            MQIqSelectedCell *ipCell = (MQIqSelectedCell *)cell;
            ipCell.titleL.text = self.titles[indexPath.row];
            ipCell.contentL.text = _adress;
        }
            break;
        case 3:
        {
            MQCerLocationCell *titleCell = (MQCerLocationCell *)cell;
            titleCell.rightV.image = [UIImage imageNamed:@"position"];
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _desAdd;
            
        }
            break;
        case 4:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入法人代表";
            _representativeT = titleCell.contentT;
            
        }
            break;
        case 5:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _scale.Text;
        }
            break;
        case 6:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _Nature.Text;
        }
            break;
        case 7:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _introduce;
        }
            break;
        case 8:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _models.count>0?@"查看已选资质":@"请选择具备资质";
        }
            break;
       
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
        
        [self.pickerView show];
        [self.view endEditing:YES];
        
    }else if (indexPath.row ==3) {
        if (!_adress||_adress.length==0) {
            [MBProgressHUD showAutoMessage:@"请先选择公司所在地"];
            return;
        }
        MQMapController *vc = [MQMapController new];
        vc.adress = _adress;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:CompanyScale andDirection:NO];
        dropV.tag = indexPath.row;
        dropV.delegate = self;
    }else if (indexPath.row == 6){
        [self.view endEditing:YES];
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:comNature andDirection:NO];
         dropV.tag = indexPath.row;
        dropV.delegate = self;
    }else if (indexPath.row == 7){
        //经营范围
        MQEqDesController *desVC = [MQEqDesController new];
        desVC.desText = _introduce;
        [desVC setTextBlock:^(NSString *text) {
            _introduce = text;
            [_tableView roloadCell:0 andRow:7];
        }];
        desVC.navigationItem.title = @"企业介绍";
        desVC.placeStr = @"至少10个字";
        [self.navigationController pushViewController:desVC animated:YES];
    }else if (indexPath.row == 8){
        MQAddCerController *addVC = [MQAddCerController new];
        addVC.addModels = _models;
        __weak typeof(self) weakSelf = self;
        [addVC setAlreadyBlock:^(NSArray *addModels) {
            //保存已选资质证书
            weakSelf.models = addModels;
            //刷新资质证书cell
            [weakSelf.tableView roloadCell:indexPath.section andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:addVC animated:YES];
    }
}

//地址选择代理
- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
    _A = area;
    _adress = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
    [_tableView roloadCell:0 andRow:2];
    [_pickerView hide];
}

//企业性质代理
- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (dropView.tag == 5) {
        _scale = item;
    }else{
      _Nature = item;
    }
    
    [_tableView roloadCell:0 andRow:dropView.tag];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}

//获取详细地址通知
- (void)relodDesAddress:(NSNotification *)noti
{
    _desAdd = (NSString *)noti.object;
     [_tableView roloadCell:0 andRow:3];
}

- (void)pubBtnClicked
{

    if (_registerT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入注册号"];
        return;
    }
    
    if (_companyNameT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入公司全称"];
        return;
    }
    if (_adress.length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择企业所在地"];
        return;
    }
    
    if (_desAdd.length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择公司详细地址"];
        return;
    }
    if (_representativeT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入法人代表"];
        return;
    }
    
    if (_scale.Text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择企业规模"];
        return;
    }
    
    if (_Nature.Text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择企业性质"];
        return;
    }
    
    if (_introduce.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入企业介绍"];
        return;
    }
    
    if (_headerV.imgUrl.length == 0) {
        [MBProgressHUD showAutoMessage:@"请上传营业执照"];
        return;
    }
    
    if (_models.count==0) {
        [MBProgressHUD showAutoMessage:@"请选择具备资质"];
        return;
    }
    NSMutableArray *cres = [NSMutableArray array];
    [_models enumerateObjectsUsingBlock:^(MQSubCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:obj.ID forKey:@"qualifictionId"];
        [dic setObject:@"" forKey:@"img"];
        [cres addObject:dic];
    }];
    NSDictionary *pram = @{
                           @"ImgUrl":_headerV.imgUrl,
                           @"CompanyName":_companyNameT.text,
                           @"RegisNumber":_registerT.text,
                           @"Name":_representativeT.text,
                           @"CompanyType":@(_Nature.index+1),
                           @"CompanyScale":@(_scale.index+1),
                           @"Province":@(_P.ID),
                           @"City":@(_C.ID),
                           @"Area":@(_A.ID),
                           @"Address":_desAdd,
                           @"Content":_introduce,
                           @"Qualifications":cres
                           };
  
    NSString *urlStr = nil;
    if (_state == 2) {
        urlStr = API_updateJobCompany;
    }else{
        urlStr = API_addJobCompany;
    }
    [self hudNavWithTitle:@"提交中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:urlStr withParameters:pram success:^(id res) {
        
         [self hideHudFromNav];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(id error) {
          [self hideHudFromNav];
    }];
    
}

-(NSArray *)titles
{
    return @[@"注册号",@"企业全称",@"企业所在地",@"详细地址",@"法人代表",@"企业规模",@"企业性质",@"企业介绍",@"具备资质"];
}
@end
