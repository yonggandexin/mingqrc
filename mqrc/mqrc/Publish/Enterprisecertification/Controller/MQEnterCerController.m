//
//  MQEnterCerController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEnterCerController.h"
#import "MQHeader.h"
#import "MQEqPriceCell.h"
#import "MQEqTitleCell.h"
#import "MQIqSelectedCell.h"
#import "MQEqCerFootView.h"
#import "MQResaultController.h"
#import "MQCustomField.h"
#import "MQCustomLable.h"
#import "MQEqDesController.h"
#import "AddressPickerView.h"
#import "MQEqAcqDes.h"
#import "MQPubHeaderView.h"
#import "MQCheckStateModel.h"
#import "MQOcrBusModel.h"
@interface MQEnterCerController ()
<
UITableViewDelegate,
UITableViewDataSource,
TZImagePickerControllerDelegate,
DropDelegate,
PGDatePickerDelegate,
AddressPickerViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) MQEqCerFootView *footV;

@property (nonatomic, copy) UITextField *registerT;

@property (nonatomic, strong) UITextField *comNameT;

@property (nonatomic, strong) MQCustomLable *comTypeL;

@property (nonatomic, strong) MQCustomLable *addressT;

@property (nonatomic, strong) UITextField *dbiaoT;

@property (nonatomic, strong) UITextField *registerP;

@property (nonatomic, strong) UITextField *actualP;

@property (nonatomic, strong) MQCustomLable *chengDate;

@property (nonatomic, strong) MQCustomLable *yingDate;

@property (nonatomic, strong) MQCustomLable *yingRange;

@property (nonatomic, copy) NSString *comType;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) MQPubHeaderView *headerV;
@property (nonatomic, strong) MQOcrBusModel *ocrModel;
@property (nonatomic, strong) NSMutableArray <NSString *>*sectionTwo;
@end

@implementation MQEnterCerController

- (NSMutableArray <NSString *>*)sectionTwo
{
    if (!_sectionTwo) {
        _sectionTwo = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            [_sectionTwo addObject:@""];
        }
    }
    return _sectionTwo;
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (void)viewDidLoad {
    self.navigationItem.title = @"企业认证";
    [super viewDidLoad];
    
    [self loadData];
    
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
}

- (void)contentTextFieldDidEndEditing:(NSNotification *)noti {
    MQCustomField *textField = noti.object;
    NSString *text = textField.text;
    NSInteger row =textField.indexPath.row;
    [self.sectionTwo replaceObjectAtIndex:row withObject:text];
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 30, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;
    
    MQPubHeaderView *headerV = [[NSBundle mainBundle]loadNibNamed:@"MQPubHeaderView" owner:nil options:nil][0];
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7);
    headerV.imgUrl = _model.IMG_URL;
    headerV.vc = self;
    [headerV setIT_Block:^(NSString *baseStr) {
        [self OcrBusinessLicense:baseStr];
    }];
    tableView.tableHeaderView = headerV;
    _headerV = headerV;

    [tableView registerCellName:[MQFrameLableCell class]];
    [tableView registerCellName:[MQFrameFiledCell class]];
    [self.view addSubview:self.pickerView];
    
}

- (void)OcrBusinessLicense:(NSString *)str
{
    NSDictionary *pram = @{
                           @"filedata":str
                           };
    [self hudNavWithTitle:@"识别中..."];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_OcrBusinessLicense withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQOcrBusModel *model = [MQOcrBusModel mj_objectWithKeyValues:res];
        _ocrModel = model;
        [_tableView reloadData];
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [UILabel new];
    lable.x = 10;
    lable.y = 0;
    lable.width = SCREEN_WIDTH-10;
    lable.height = 30;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    if (section == 0) {
        lable.text = @"上传营业执照系统会自动识别";
    }else{
        lable.text = @"以下四项需手动输入";
    }
   
    [header addSubview:lable];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
    return 6;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    
    if (indexPath.section == 0) {
        cellID = NSStringFromClass([MQFrameLableCell class]);
    }else{
        if (indexPath.row == 0 || indexPath.row == 1) {
            cellID = NSStringFromClass([MQFrameLableCell class]);
        }else{
            cellID = NSStringFromClass([MQFrameFiledCell class]);
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0) {
        MQFrameLableCell *ocrCell = (MQFrameLableCell *)cell;
        ocrCell.starL.hidden = YES;
        ocrCell.arrowV.hidden = YES;
        [ocrCell cellIsFirst:indexPath.row == 0];
        ocrCell.titleL.text = self.titles[indexPath.row];
        if (_ocrModel) {
            switch (indexPath.row) {
                case 0:
                    ocrCell.contentL.text = _ocrModel.RegisNum;
                    break;
                case 1:
                    ocrCell.contentL.text = _ocrModel.CompanyName;
                    break;
                case 2:
                    ocrCell.contentL.text = _ocrModel.Name;
                    break;
                case 3:
                    ocrCell.contentL.text = _ocrModel.EstablishDate;
                    break;
                case 4:
                    ocrCell.contentL.text = _ocrModel.EndTime;
                    break;
                case 5:
                    ocrCell.contentL.text = _ocrModel.Bussiness;
                    break;
                default:
                    break;
            }
      }
    }else{
        if (indexPath.row == 0 || indexPath.row == 1) {
            MQFrameLableCell *styleCell = (MQFrameLableCell *)cell;
            styleCell.arrowV.hidden = NO;
            if (indexPath.row == 0) {
                styleCell.titleL.text = @"企业类型";
            }else{
                styleCell.titleL.text = @"企业地址";
            }
            styleCell.contentL.text = self.sectionTwo[indexPath.row];
            [styleCell cellIsFirst:indexPath.row == 0];
            styleCell.starL.hidden = NO;
        }else{
            MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
            filedCell.contentFiled.indexPath = indexPath;
            filedCell.starL.hidden = NO;
            filedCell.contentFiled.placeholder = @"单位为万元";
            filedCell.contentFiled.keyboardType = UIKeyboardTypeNumberPad;
            [filedCell cellIsFirst:indexPath.row == 0];
            if (indexPath.row == 2) {
                filedCell.titleL.text = @"注册资本";
            }else{
                filedCell.titleL.text = @"实缴资本";
            }
            
        }
    }
    
   /*
    switch (indexPath.row) {
        case 0:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入注册号";
            titleCell.contentT.text = _model.REGISTRATION_NUMBER;
            _registerT = titleCell.contentT;
        }
            break;
        case 1:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入公司名称";
            titleCell.contentT.text = _model.COMPANY_NAME;
            _comNameT = titleCell.contentT;
        }
            break;
        case 2:
        {
            MQIqSelectedCell *ipCell = (MQIqSelectedCell *)cell;
            ipCell.titleL.text = self.titles[indexPath.row];
            ipCell.contentL.text = _model.COMPANY_TYPE;
            _comTypeL = ipCell.contentL;
        }
            break;
        case 3:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _model.REGISTERED_ADDRESS;
            _addressT = titleCell.contentL;
        }
            break;
        case 4:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入法人代表";
            titleCell.contentT.text = _model.LEGALREPRESENTATIVE;
            _dbiaoT = titleCell.contentT;
        }
            break;
        case 5:
        {
            MQEqPriceCell *priceCell = (MQEqPriceCell *)cell;
            priceCell.titleL.text = self.titles[indexPath.row];
            priceCell.contentT.text = [NSString stringWithFormat:@"%.f", _model.REGISTEREDCAPITAL ];
            _registerP = priceCell.contentT;
        }
            break;
        case 6:
        {
            MQEqPriceCell *priceCell = (MQEqPriceCell *)cell;
            priceCell.titleL.text = self.titles[indexPath.row];
            priceCell.contentT.text = [NSString stringWithFormat:@"%.f", _model.PAIDCAPITAL ];
            _actualP = priceCell.contentT;
        }
            break;
        case 7:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _model.REGISTRATIONDATE;
            _chengDate = titleCell.contentL;
        }
            break;
        case 8:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _model.OPERATING_PERIOD;
            _yingDate = titleCell.contentL;
        }
            break;
        case 9:
        {
            MQIqSelectedCell *titleCell = (MQIqSelectedCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentL.text = _model.BUSINESS_SCOPE;
            _yingRange = titleCell.contentL;
        }
            break;
        default:
            break;
    }
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        if (indexPath.row == 0){
            [self.view endEditing:YES];
            MQDropTypeView *dropV = [MQDropTypeView showWithItems:comNature andDirection:NO];
            dropV.delegate = self;
        }else if(indexPath.row == 1){
            [self.pickerView show];
            [self.view endEditing:YES];
        }
    }
  
    
}
//地址选择代理
- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
    [self.sectionTwo replaceObjectAtIndex:1 withObject:address];
    [_tableView roloadCell:1 andRow:1];
    [_pickerView hide];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}

//选择日期代理
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if (datePicker.tag == 101) {
//        _model.REGISTRATIONDATE = [NSString stringWithFormat:@"%zd-%zd-%zd",dateComponents.year,dateComponents.month,dateComponents.day];
        [_tableView roloadCell:0 andRow:7];
    }else if (datePicker.tag == 100){
//        _model.OPERATING_PERIOD = [NSString stringWithFormat:@"%zd-%zd-%zd",dateComponents.year,dateComponents.month,dateComponents.day];
        [_tableView roloadCell:0 andRow:8];
    }
   
    
}

//选择收购类型代理
- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    [self.sectionTwo replaceObjectAtIndex:0 withObject:item.Text];
    [_tableView roloadCell:1 andRow:0];
}
- (void)loadData
{
    
}

/**
保存
 */
- (void)pubBtnClicked
{
    
    if(_headerV.imgUrl == nil){
        [MBProgressHUD showAutoMessage:@"请上传营业执照图片"];
        return;
    }
    
    if (!_ocrModel) {
        [MBProgressHUD showAutoMessage:@"营业执照未识别成功"];
        return;
    }
    
    if (self.sectionTwo[0].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择公司类型"];
        return;
    }
    
    if (self.sectionTwo[1].length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择公司注册地址"];
        return;
    }
    if (self.sectionTwo[2].length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入注册资本"];
        return;
    }
    if (self.sectionTwo[3].length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入实缴资本"];
        return;
    }
    
    
    NSDictionary *pram = @{
                           @"registration_number":_ocrModel.RegisNum,
                           @"company_name":_ocrModel.CompanyName,
                           @"company_type":_sectionTwo[0],
                           @"registered_address":_sectionTwo[1],
                           @"registeredcapital":_sectionTwo[2],
                           @"paidcapital":_sectionTwo[3],
                           @"legalrepresentative":_ocrModel.Name,
                           @"registrationdate":_ocrModel.EstablishDate,
                           @"operating_period":_ocrModel.EndTime,
                           @"business_scope":_ocrModel.Bussiness,
                           @"img_url":_headerV.imgUrl
                           };
    
    
    [MBProgressHUD showMessage:@"保存中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_addCorporateCertification withParameters:pram success:^(id res) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view  animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id error) {
//        [MBProgressHUD showAutoMessage:@"保存失败"];
        [MBProgressHUD hideHUDForView:self.navigationController.view  animated:YES];
    }];
    
    
}

-(NSArray *)titles
{
    return @[@"注册号",@"公司名称",@"法人代表",@"成立日期",@"营业期限",@"经营范围"];
}
@end
