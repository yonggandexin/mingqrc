//
//  MQEqTransferController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEqTransferController.h"
#import "MQHeader.h"
#import "MQEqPriceCell.h"
#import "MQEqTitleCell.h"
#import "MQIqSelectedCell.h"
#import "AddressPickerView.h"
#import "MQCertificateController.h"
#import "Province.h"
#import "City.h"
#import "Area.h"
#import "MQResaultView.h"
#import "MQAddCerController.h"
#import "MQEqHlightModel.h"
#import "MQeqLightsCell.h"
#import "MQEqDesController.h"
#import "MQIndustyModel.h"
#import "MQSubCerModel.h"
#import "MQResaultController.h"
#import "MQPubHeaderView.h"
#import "MQCustomField.h"
#import "MQCustomLable.h"
#import "MQCheckStateModel.h"
#import "MQTranShowModel.h"
#import "MQTransUpdateModel.h"
@interface MQEqTransferController ()
<
UITableViewDelegate,
UITableViewDataSource,
AddressPickerViewDelegate,
TZImagePickerControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSMutableArray *hLights;
@property (nonatomic, strong) Province *P;
@property (nonatomic, strong) City *C;
@property (nonatomic, strong) Area *A;

@property (nonatomic, strong) UIImageView *headerV;

@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, strong) NSArray *placeHolds;

@property (nonatomic, strong) MQTransUpdateModel *updateModel;
@end

@implementation MQEqTransferController
- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[
                    @[@"发布标题",@"转让价格"],
                    @[@"所在地区",@"资质证书",@"企业亮点",@"人员情况",@"姓名",@"手机",@"微信",@"邮箱"]
                    ];
    }
    return _titles;
}

- (NSArray *)placeHolds
{
    if (!_placeHolds) {
        _placeHolds = @[
                        @[@"请输入标题",@""],
                        @[@"",@"",@"",@"",@"请输入姓名",@"请填写正确的手机号",@"请填写微信",@"请填写邮箱"]
                        ];
    }
    return _placeHolds;
}

- (NSArray *)contents {
    if (!_contents) {
        NSMutableArray *top = [NSMutableArray array];
        NSMutableArray *bottom = [NSMutableArray array];
        for (int i = 0; i<2; i++) {
            [top addObject:@""];
        }
        for (int i = 0; i<8; i++) {
            [bottom addObject:@""];
        }
        _contents = @[top,bottom];
    }
    return _contents;
}
- (NSMutableArray *)hLights
{
    if (!_hLights) {
        _hLights = [NSMutableArray array];
    }
    return _hLights;
}
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_barH , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];

    if (self.isMine == YES) {
        [self loadUpdateData];
    }
    
    self.navigationItem.title = @"发布股权转让";
    [self loadHlightsData];
    
    [self initUI];
    
    [self.view addSubview:self.pickerView];
}

- (void)loadUpdateData
{
    [self hudNavWithTitle:@"请求中..."];
    NSDictionary *pram = @{
                           @"id":_transModel.ID
                           };
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_GetPublishShareTransferInfo withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQTransUpdateModel *model = [MQTransUpdateModel mj_objectWithKeyValues:res];
        _updateModel = model;
        [self reloadUpdateModel];
        
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
    
}

- (void)reloadUpdateModel
{
    [self setHeadImg:_updateModel.ImgUrl];
    NSMutableArray *top = self.contents[0];
    [top replaceObjectAtIndex:0 withObject:_updateModel.Title];
    [top replaceObjectAtIndex:1 withObject:_updateModel.Price];
    
    NSMutableArray *bottom = self.contents[1];
    [self sureBtnClickReturnProvince:_updateModel.Province City:_updateModel.City Area:_updateModel.Area];
    _models = _updateModel.Qualifications;
    [self cerStatus];
    [bottom replaceObjectAtIndex:3 withObject:_updateModel.Personnel];
    [bottom replaceObjectAtIndex:4 withObject:_updateModel.Name];
    [bottom replaceObjectAtIndex:5 withObject:_updateModel.Mobile];
    [bottom replaceObjectAtIndex:6 withObject:_updateModel.Wechat];
    [bottom replaceObjectAtIndex:7 withObject:_updateModel.Email];
    [_tableView reloadData];
}

- (void)cerStatus
{
    //刷新资质证书cell
    NSString *str = _models.count>0?@"查看已选资质证书":@"选择资质证书";
    [self.contents[1] replaceObjectAtIndex:1 withObject:str];
    [_tableView roloadCell:1 andRow:1];
}

// 在这个方法中，我们就可以通过自定义textField的indexPath属性区分不同行的cell，然后拿到textField.text
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti {
    MQCustomField *textField = noti.object;
        NSString *text = textField.text;
        NSInteger row =textField.indexPath.row;
        NSMutableArray *mutArr = self.contents[textField.indexPath.section];
        [mutArr replaceObjectAtIndex:row withObject:text];
}

- (void)initUI
{
    
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
    [sureBtn setTitle:@"发布" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    tableView.tableFooterView = footView;
    _tableView = tableView;
    
    
    //显示营业执照
    UIImageView *headerV = [UIImageView new];
    headerV.backgroundColor = baseColor;
    headerV.contentMode = UIViewContentModeScaleAspectFit;
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6);
    tableView.tableHeaderView = headerV;
    _headerV = headerV;
    [self setHeadImg:_stateModel.IMG_URL];
    
    [tableView registerCellName:[MQFrameFiledCell class]];
    [tableView registerCellName:[MQFrameLableCell class]];
    [tableView registerCellName:[MQFramePriceCell class]];
    [tableView registerCellName:[MQeqLightsCell class]];
}

- (void)setHeadImg:(NSString *)urlStr
{
    NSString *url = [NSString stringWithFormat:@"%@%@",imgTestIP,urlStr];
    [_headerV sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}

- (void)loadHlightsData
{
    NSDictionary *pram = @{
                           @"type":@"0"
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetSharesExcellenceList withParameters:pram success:^(id res) {
        NSArray *excellences = [res objectForKey:@"Excellences"];
        [excellences enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQEqHlightModel *model = [MQEqHlightModel mj_objectWithKeyValues:obj];
            [self.hLights addObject:model];
            [self.tableView roloadCell:1 andRow:2];
        }];
    } failure:^(id error) {
        
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *Arr = [self.contents objectAtIndex:indexPath.section];
     NSArray *titleArr = self.titles[indexPath.section];
     NSArray *placeHold = self.placeHolds[indexPath.section];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
            filedCell.titleL.text = titleArr[indexPath.row];
            filedCell.contentFiled.text = [Arr objectAtIndex:indexPath.row];
            [filedCell cellIsFirst:indexPath.row == 0];
            filedCell.contentFiled.placeholder = placeHold[indexPath.row];
        }else{
            MQFramePriceCell *priceCell = (MQFramePriceCell *)cell;
            priceCell.titleL.text =titleArr[indexPath.row];
            priceCell.contentFiled.text = [Arr objectAtIndex:indexPath.row];
            [priceCell cellIsFirst:indexPath.row == 0];
        }
    }else if (indexPath.section == 1){
        if(indexPath.row == 2){
            MQeqLightsCell *lightCell  =(MQeqLightsCell *)cell;
            lightCell.lable.text = titleArr[indexPath.row];
            lightCell.hLights = self.hLights;
            
        }else if (indexPath.row == 0||indexPath.row ==1||indexPath.row == 3){
            MQFrameLableCell *lableCell = (MQFrameLableCell *)cell;
            lableCell.contentL.text = [Arr objectAtIndex:indexPath.row];
            lableCell.titleL.text = titleArr[indexPath.row];
            [lableCell cellIsFirst:indexPath.row == 0];
           
        }else{
            MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
            filedCell.contentFiled.text = [Arr objectAtIndex:indexPath.row];
            filedCell.titleL.text = titleArr[indexPath.row];
            [filedCell cellIsFirst:indexPath.row == 0];
            filedCell.contentFiled.placeholder = placeHold[indexPath.row];
            if (indexPath.row == 6||indexPath.row == 7) {
                filedCell.starL.hidden = YES;
            }else{
                filedCell.starL.hidden = NO;
            }
        }
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UILabel *lable = [UILabel new];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = font(10);
        lable.text = @"    提示：为保护您的权益，此价格数据仅做参考不显示在前端";
        lable.textColor = [UIColor redColor];
        return lable;
    }
   
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            return 100;
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellID = NSStringFromClass([MQFrameFiledCell class]);
        }else{
            cellID = NSStringFromClass([MQFramePriceCell class]);
        }
    }else if (indexPath.section == 1){
        if(indexPath.row == 2){
            cellID = NSStringFromClass([MQeqLightsCell class]);
        }else if (indexPath.row == 0||indexPath.row ==1||indexPath.row == 3){
            cellID = NSStringFromClass([MQFrameLableCell class]);
        }else{
            cellID = NSStringFromClass([MQFrameFiledCell class]);
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
            filedCell.contentFiled.indexPath = indexPath;
        }else{
            MQFramePriceCell *priceCell = (MQFramePriceCell *)cell;
            priceCell.contentFiled.indexPath = indexPath;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0||indexPath.row ==1||indexPath.row == 3){

        }else if(indexPath.row!=2){
            MQFrameFiledCell *filedCell = (MQFrameFiledCell *)cell;
            filedCell.contentFiled.indexPath = indexPath;
        }else{
            
            
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.pickerView show];
            [self.view endEditing:YES];
        }else if (indexPath.row == 1){
            
            MQAddCerController *addVC = [MQAddCerController new];
            addVC.addModels = _models;
            __weak typeof(self) weakSelf = self;
            [addVC setAlreadyBlock:^(NSArray *addModels) {
                //保存已选资质证书
                weakSelf.models = addModels;
                [self cerStatus];
            }];
            [self.navigationController pushViewController:addVC animated:YES];
        }else if (indexPath.row == 3){
            //人员情况
            MQEqDesController *desVC = [MQEqDesController new];
            desVC.desText = self.contents[indexPath.section][indexPath.row];
            [desVC setTextBlock:^(NSString *text) {
                [self.contents[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:text];
                [_tableView roloadCell:indexPath.section andRow:indexPath.row];
            }];
            desVC.navigationItem.title = @"人员情况";
            desVC.placeStr = @"至少10个字";
            [self.navigationController pushViewController:desVC animated:YES];
        }
    }
    
}

- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
    _A = area;
    
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
    
    [self.contents[1] replaceObjectAtIndex:0 withObject:address];
    
    [_tableView roloadCell:1 andRow:0];
    
    [_pickerView hide];
}

- (void)cancelBtnClick
{
    [_pickerView hide];
}

- (void)pubBtnClicked
{

    //获取体选择的亮点
    NSMutableArray *selsL = [NSMutableArray array];
    [self.hLights enumerateObjectsUsingBlock:^(MQEqHlightModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSel == YES) {
            [selsL addObject:obj.ID];
        }
    }];
   
    if (((NSString *)_contents[0][0]).length<8) {
        [MBProgressHUD showAutoMessage:@"标题字数不得少于8个"];
        return;
    }
    if(((NSString *)_contents[0][1]).length == 0){
        [MBProgressHUD showAutoMessage:@"请输入转让价格"];
        return;
    }
    
    if(((NSString *)_contents[1][0]).length == 0){
        [MBProgressHUD showAutoMessage:@"请输入所在地区"];
        return;
    }
    if(_models.count == 0){
        [MBProgressHUD showAutoMessage:@"请添加证书要求"];
        return;
    }
    
    
    if(selsL.count == 0){
        [MBProgressHUD showAutoMessage:@"选一个企业亮点吧"];
        return;
    }
    
    if(selsL.count > 3){
        [MBProgressHUD showAutoMessage:@"企业亮点最多只能选三个噢"];
        return;
    }
    
    if(((NSString *)_contents[1][3]).length == 0){
        [MBProgressHUD showAutoMessage:@"请填写人员情况"];
        return;
    }
    
    if(((NSString *)_contents[1][4]).length == 0){
        [MBProgressHUD showAutoMessage:@"请填姓名"];
        return;
    }
    if(![ValiDateTool checkTelNumber:((NSString *)_contents[1][5])]){
        [MBProgressHUD showAutoMessage:@"请填写正确的手机号"];
        return;
    }

    //获取已选证书ID集合
    NSMutableArray *cerIDs = [NSMutableArray array];
    
    [self.models enumerateObjectsUsingBlock:^(MQSubCerModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
      
        NSString * imgUrl =  model.ImgUrl.length>0?model.ImgUrl:@"";
        NSDictionary *cerDic = @{
                                 @"qualifictionId":model.ID,
                                 @"img":imgUrl
                                 };
        [cerIDs addObject:cerDic];
    }];

    NSString *urlStr = nil;
    NSString *companyId = nil;
    NSString *imgUrl = nil;
    NSString *ID = nil;
    if (self.isMine == YES) {
        urlStr = API_updateSharesTransferInfo;
        companyId = @"";
        imgUrl = _updateModel.ImgUrl;
        ID = _updateModel.ID;
    }else{
        urlStr = API_addSharesTransfer;
        companyId = _stateModel.ID;
        imgUrl = _stateModel.IMG_URL;
        ID = @"";
    }
    NSDictionary *pram = @{
                           @"title":((NSString *)_contents[0][0]),
                           @"price":((NSString *)_contents[0][1]),
                           @"provinceId":@(_P.ID),
                           @"city":@(_C.ID),
                           @"area":@(_A.ID),
                           @"transfer_industry_id":industry_ID,
                           @"qualifications":cerIDs,
                           @"ls_Shares_excellence":selsL,
                           @"personnel":((NSString *)_contents[1][3]),
                           @"content":@"",
                           @"name":((NSString *)_contents[1][4]),
                           @"mobile":((NSString *)_contents[1][5]),
                           @"wechat":((NSString *)_contents[1][6]),
                           @"email":((NSString *)_contents[1][7]),
                           @"img_Url":imgUrl,
                           @"companyId":companyId,
                           @"ID":ID
                           };
  
    [MBProgressHUD showMessage:@"发布中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:urlStr withParameters:pram success:^(id res) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        MQResaultController *vc = [MQResaultController new];
        vc.desStr = @"发布成功";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}


@end
