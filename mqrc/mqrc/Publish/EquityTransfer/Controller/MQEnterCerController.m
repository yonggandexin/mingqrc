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
@interface MQEnterCerController ()
<
UITableViewDelegate,
UITableViewDataSource,
TZImagePickerControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) MQEqCerFootView *footV;

@property (nonatomic, copy) UITextField *registerT;

@property (nonatomic, strong) UITextField *comNameT;

@property (nonatomic, strong) UILabel *comTypeL;

@property (nonatomic, strong) UITextField *addressT;

@property (nonatomic, strong) UITextField *dbiaoT;

@property (nonatomic, strong) UITextField *registerP;

@property (nonatomic, strong) UITextField *actualP;

@property (nonatomic, strong) UITextField *chengDate;

@property (nonatomic, strong) UITextField *yingDate;

@property (nonatomic, strong) UITextField *yingRange;


@property (nonatomic, copy) NSString *imgUrl;
@end

@implementation MQEnterCerController

- (void)viewDidLoad {
    self.navigationItem.title = @"企业认证";
    [super viewDidLoad];
    
    [self loadData];
    
    [self initUI];
    
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    MQEqCerFootView *footV = [[NSBundle mainBundle]loadNibNamed:@"MQEqCerFootView" owner:nil options:nil][0];
    [footV.postPhotoBtn addTarget:self action:@selector(photoClicked) forControlEvents:UIControlEventTouchUpInside];
    [footV.PreservationBtn addTarget:self action:@selector(preservation:) forControlEvents:UIControlEventTouchUpInside];
    [footV.disBtn addTarget:self action:@selector(disPhoto:) forControlEvents:UIControlEventTouchUpInside];
    tableView.tableFooterView = footV;
    
    _footV = footV;
    
    [tableView registerCellNibName:[MQEqPriceCell class]];
    [tableView registerCellNibName:[MQEqTitleCell class]];
    [tableView registerCellNibName:[MQIqSelectedCell class]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 2) {
        cellID = NSStringFromClass([MQIqSelectedCell class]);
    }else if(indexPath.row == 5||indexPath.row == 6){
        cellID = NSStringFromClass([MQEqPriceCell class]);
    }else{
        cellID = NSStringFromClass([MQEqTitleCell class]);
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
            titleCell.contentT.placeholder = @"请输入公司名称";
            _comNameT = titleCell.contentT;
        }
            break;
        case 2:
        {
            MQIqSelectedCell *ipCell = (MQIqSelectedCell *)cell;
            ipCell.titleL.text = self.titles[indexPath.row];
            _comTypeL = ipCell.contentL;
        }
            break;
        case 3:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入注册地址";
            _addressT = titleCell.contentT;
        }
            break;
        case 4:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入法人代表";
            _dbiaoT = titleCell.contentT;
        }
            break;
        case 5:
        {
            MQEqPriceCell *priceCell = (MQEqPriceCell *)cell;
            priceCell.titleL.text = self.titles[indexPath.row];
            _registerP = priceCell.contentT;
        }
            break;
        case 6:
        {
            MQEqPriceCell *priceCell = (MQEqPriceCell *)cell;
            priceCell.titleL.text = self.titles[indexPath.row];
            _actualP = priceCell.contentT;
        }
            break;
        case 7:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请选择成立日期";
            _chengDate = titleCell.contentT;
        }
            break;
        case 8:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请选择营业期限";
            _yingDate = titleCell.contentT;
        }
            break;
        case 9:
        {
            MQEqTitleCell *titleCell = (MQEqTitleCell *)cell;
            titleCell.titleL.text =self.titles[indexPath.row];
            titleCell.contentT.placeholder = @"请输入经营范围";
            _yingRange = titleCell.contentT;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)loadData
{
    
}

/**
 打开相机
 */
- (void)photoClicked
{
    if (_footV.imgV.image) {
        [MBProgressHUD showAutoMessage:@"最多只能上传一张照片"];
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self uploadImage:photos[0]];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 删除照片
 */
- (void)disPhoto:(UIButton *)btn
{
    _footV.imgV.image = nil;
    btn.hidden = YES;
}

/**
 上传照片
 */
- (void)uploadImage:(UIImage *)image
{
    [[NetworkHelper shareInstance] uploadImage:image success:^(id res) {
        _footV.imgV.image = image;
        _footV.disBtn.hidden = NO;
        _imgUrl = res;
    } failure:^(NSString *error) {
        
    }];
}

/**
保存
 */
- (void)preservation:(UIButton *)btn
{
    
    if (_registerT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入注册号"];
        return;
    }
    
    if (_comNameT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入公司名称"];
        return;
    }
    if (_comTypeL.text.length == 0) {
//        [MBProgressHUD showAutoMessage:@"请选择公司类型"];
//        return;
    }
    
    if (_addressT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请选择公司注册地址"];
        return;
    }
    if (_dbiaoT.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入法人代表"];
        return;
    }
    
    if (_registerP.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入注册资本"];
        return;
    }
    
    if (_chengDate.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入成立日期"];
        return;
    }
    
    if (_yingDate.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入营业期限"];
        return;
    }
    
    if (_yingRange.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"请输入经营范围"];
        return;
    }
    
    if(_footV.imgV.image == nil){
        [MBProgressHUD showAutoMessage:@"请上传营业执照图片"];
        return;
    }
    
    NSDictionary *pram = @{
                           @"registration_number":_registerT.text,
                           @"company_name":_comNameT.text,
                           @"company_type":@"国有企业",
                           @"registered_address":_addressT.text,
                           @"registeredcapital":_registerP.text,
                           @"paidcapital":_actualP.text,
                           @"legalrepresentative":_dbiaoT.text,
                           @"registrationdate":_chengDate.text,
                           @"operating_period":_yingDate.text,
                           @"business_scope":_yingRange.text,
                           @"img_url":_imgUrl
                           };
    
    
    [MBProgressHUD showMessage:@"保存中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_addCorporateCertification withParameters:pram success:^(id res) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view  animated:YES];
        [self.navigationController pushViewController:[MQResaultController new] animated:YES];
    } failure:^(NSString *error) {
        
        [MBProgressHUD showAutoMessage:@"保存失败"];
        [MBProgressHUD hideHUDForView:self.navigationController.view  animated:YES];
    }];
    
    
}

-(NSArray *)titles
{
    return @[@"注册号",@"公司名称",@"公司类型",@"注册地址",@"法人代表",@"注册资本",@"实缴资本",@"成立日期",@"营业期限",@"经营范围"];
}
@end
