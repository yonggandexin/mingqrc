//
//  MQJobPerresumeVC.m
//  mqrc
//
//  Created by 朱波 on 2017/12/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQJobPerresumeVC.h"
#import "MQHeader.h"
#import "MQPubHeaderView.h"
#import "MQCustomField.h"
#import "AddressPickerView.h"
#import "MQEqDesController.h"
#import "MQPreviewResumeVC.h"
#import "MQResumeModel.h"
#import "MQLoginModel.h"
@interface MQJobPerresumeVC ()
<
UITableViewDelegate,
UITableViewDataSource,
DropDelegate,
PGDatePickerDelegate,
AddressPickerViewDelegate
>
@property (nonatomic, strong) MQPubHeaderView *headerV;
@property (nonatomic, strong) NSMutableArray <NSString *> *contents;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *placeHolds;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddressPickerView *pickerView;
@property (nonatomic, strong) Province *P;
@property (nonatomic, strong) City *C;
@property (nonatomic, strong) Area *A;
@property (nonatomic, assign) BOOL isNowAdress;
@property (nonatomic, strong) Item *ExperienceItem;
@end

@implementation MQJobPerresumeVC
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_barH , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (NSMutableArray<NSString *> *)contents
{
    if (!_contents) {
        _contents = [NSMutableArray array];
        for (int i =0; i<self.titles.count; i++) {
            [_contents addObject:@""];
        }
    }
    return _contents;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
    [self.view addSubview:self.pickerView];
}

- (void)initUI
{
    if (_model) {
        [self.contents replaceObjectAtIndex:0 withObject:_model.Name];
        [self.contents replaceObjectAtIndex:1 withObject:_model.Sex];
        [self.contents replaceObjectAtIndex:2 withObject:_model.BirthDay];
        [self.contents replaceObjectAtIndex:3 withObject:_model.LiveAddress];
        [self.contents replaceObjectAtIndex:4 withObject:_model.HomeTown];
        [self.contents replaceObjectAtIndex:5 withObject:_model.MaxEducation];
        [self.contents replaceObjectAtIndex:6 withObject:Experience[_model.WorkTime]];
        _ExperienceItem.index = _model.WorkTime;
        [self.contents replaceObjectAtIndex:7 withObject:_model.Email];
        [self.contents replaceObjectAtIndex:8 withObject:_model.Phone];
        [self.contents replaceObjectAtIndex:9 withObject:_model.Wechat?_model.Wechat:@""];
        [self.contents replaceObjectAtIndex:10 withObject:_model.Des?_model.Des:@""];
    }
    
    self.navigationItem.title = @"创建简历";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *headSuperV = [UIView new];
    headSuperV.backgroundColor = [UIColor whiteColor];
    headSuperV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7+10);
    MQPubHeaderView *headerV = [[NSBundle mainBundle]loadNibNamed:@"MQPubHeaderView" owner:nil options:nil][0];
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.7);
    [headerV.photoBtn setTitle:@"上传头像" forState:UIControlStateNormal];
    headerV.vc = self;
    [headSuperV addSubview:headerV];
    _tableView.tableHeaderView = headSuperV;
    _headerV = headerV;
    if (_model) {
        _headerV.imgUrl = _model.ImgUrl;
    }
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    MQBaseSureBtn *sureBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 50, SCREEN_WIDTH-40, 40);
    [sureBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"保存简历" forState:UIControlStateNormal];
    [footView addSubview:sureBtn];
    _tableView.tableFooterView = footView;
    [_tableView registerCellName:[MQFrameFiledCell class]];
    [_tableView registerCellName:[MQFrameLableCell class]];

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_lastContents[0] isEqualToString:@"全职"]){
        return 11;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0||indexPath.row == 7||indexPath.row == 8||indexPath.row == 9){
        MQFrameFiledCell *titleCell = (MQFrameFiledCell *)cell;
        titleCell.contentFiled.indexPath = indexPath;
        titleCell.contentFiled.text = [self.contents objectAtIndex:indexPath.row];
        titleCell.contentFiled.placeholder = self.placeHolds[indexPath.row];
    }else{
        MQFrameLableCell *iqCell =(MQFrameLableCell *)cell;
        iqCell.contentL.text = [self.contents objectAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 0 || indexPath.row == 7||indexPath.row == 8||indexPath.row == 9) {
        cellID = NSStringFromClass([MQFrameFiledCell class]);
    }else{
        cellID = NSStringFromClass([MQFrameLableCell class]);
    }
    MQFrameBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell cellIsFirst:indexPath.row == 0];
    cell.titleL.text = self.titles[indexPath.row];
    if (indexPath.row == 9) {
        cell.starL.hidden = YES;
    }else{
        cell.starL.hidden = NO;
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        //性别
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:@[@"男",@"女"] andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemSex;
        [self.view endEditing:YES];
    }
    
    if(indexPath.row == 2){
        //出生日期
        PGDatePicker *datePicker = [[PGDatePicker alloc]init];
        datePicker.delegate = self;
        [datePicker show];
        datePicker.datePickerType = PGPickerViewType2;
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerMode = PGDatePickerModeDate;
        datePicker.minimumDate = [NSDate setYear:1890 month:1 day:1];
        datePicker.maximumDate = [NSDate date];
    }
    if (indexPath.row == 3) {
        //现居地址
        _isNowAdress = YES;
        [self.pickerView show];
        [self.view endEditing:YES];
    }
    
    if (indexPath.row == 4) {
        //籍贯
        _isNowAdress = NO;
        [self.pickerView show];
        [self.view endEditing:YES];
    }
    
    if (indexPath.row == 5) {
        //学历
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:Requirements andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemEducation;
        [self.view endEditing:YES];
    }
    
    if(indexPath.row == 6){
        //工作年限
        MQDropTypeView *dropV = [MQDropTypeView showWithItems:Experience andDirection:NO];
        dropV.delegate = self;
        dropV.dropStyle = ItemExperience;
        [self.view endEditing:YES];
    }
    
    if(indexPath.row == 10){
        
        MQEqDesController *desVC = [MQEqDesController new];
        desVC.placeStr = @"至少10个字";
        desVC.desText = self.contents[indexPath.row];
        desVC.navigationItem.title = @"自我介绍";
        [desVC setTextBlock:^(NSString *text) {
            [self.contents replaceObjectAtIndex:indexPath.row withObject:text];
            [_tableView roloadCell:0 andRow:indexPath.row];
        }];
        [self.navigationController pushViewController:desVC animated:YES];
    }
}
- (void)dealloc
{
    [MQNotificationCent removeObserver:self];
}
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
   NSString *dateStr = [NSString stringWithFormat:@"%ld/%.2ld/%.2ld",dateComponents.year,dateComponents.month,dateComponents.day];
    [self.contents replaceObjectAtIndex:2 withObject:dateStr];
    [_tableView roloadCell:0 andRow:2];
}
- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item
{
    if (item.selectStyle == ItemSex) {
        [self.contents replaceObjectAtIndex:1 withObject:item.Text];
        [_tableView roloadCell:0 andRow:1];
    }
    
    if (item.selectStyle == ItemEducation) {
        [self.contents replaceObjectAtIndex:5 withObject:item.Text];
        [_tableView roloadCell:0 andRow:5];
        
    }
    
    if (item.selectStyle == ItemExperience) {
        [self.contents replaceObjectAtIndex:6 withObject:item.Text];
        [_tableView roloadCell:0 andRow:6];
        _ExperienceItem = item;
    }
    
}

- (void)sureBtnClickReturnProvince:(Province *)province City:(City *)city Area:(Area *)area
{
    _P = province;
    _C = city;
    _A = area;
    
    NSString *adressText = [NSString stringWithFormat:@"%@ %@ %@",province.Name,city.Name,area.Name];
     [_pickerView hide];
    if (adressText && adressText.length) {
        if (_isNowAdress == YES) {
             [self.contents replaceObjectAtIndex:3 withObject:adressText];
            [_tableView roloadCell:0 andRow:3];
        }else{
            [self.contents replaceObjectAtIndex:4 withObject:adressText];
            [_tableView roloadCell:0 andRow:4];
        }
    }
}

- (void)pubBtnClicked
{
    if (_contents[0].length == 0) {
        [MBProgressHUD showAutoMessage:@"请填写姓名"];
        return;
    }
    if (_contents[1].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择性别"];
        return;
    }
    if (_contents[2].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择出生日期"];
        return;
    }
    if (_contents[3].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择现居地址"];
        return;
    }
    if (_contents[4].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择籍贯"];
        return;
    }
    if (_contents[5].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择学历"];
        return;
    }
    if (_contents[6].length == 0){
        [MBProgressHUD showAutoMessage:@"请选择工作年限"];
        return;
    }
    if (![ValiDateTool validateEmail: _contents[7]]){
        [MBProgressHUD showAutoMessage:@"请填写正确的邮箱"];
        return;
    }
    if (![ValiDateTool checkTelNumber:_contents[8]]){
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号码"];
        return;
    }
    NSDictionary *pram = @{
                           @"QualificationIds":[_lastContents objectAtIndex:1],
                           @"PositionID":[_lastContents objectAtIndex:2],
                           @"JobTypeId":[_lastContents objectAtIndex:0],
                           @"WorkProvince":[_lastContents objectAtIndex:4],
                           @"WorkCity":[_lastContents objectAtIndex:5],
                           @"SalaryId":[_lastContents objectAtIndex:3],
                           @"Name":self.contents[0],
                           @"Sex":self.contents[1],
                           @"Birthday":self.contents[2],
                           @"LiveAddress":self.contents[3],
                           @"Hometown":self.contents[4],
                           @"Education":self.contents[5],
                           @"WorkExperience":@(_ExperienceItem.index),
                           @"Email":self.contents[7],
                           @"Mobile":self.contents[8],
                           @"Wechat":self.contents[9],
                           @"ImgUrl":_headerV.imgUrl?_headerV.imgUrl:@"",
                           @"Des":self.contents[10]
                          };
   
    if (_model) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:pram];
        [mutDic setObject:_model.ResumeID forKey:@"ID"];
        [self isUpdate:API_updateResume andPram:mutDic];
    }else{
        [self isUpdate:API_addResume andPram:pram];
    }
   

}

- (void)isUpdate:(NSString *)url andPram:(NSDictionary *)pram
{
    
    [self hudNavWithTitle:@"保存中..."];
    [[NetworkHelper shareInstance] postHttpToServerWithURL:url withParameters:pram success:^(id res) {
        [self hideHudFromNav];
        MQPreviewResumeVC *vc = [MQPreviewResumeVC new];
        vc.isCreatResume = YES;
        [self.navigationController pushViewController:vc animated:YES];
        MQLoginModel *model = [MQLoginTool shareInstance].model;
        model.IsResume = YES;
        [MQLoginTool shareInstance].model = model;
    } failure:^(id error) {
        [self hideHudFromNav];
    }];
}


- (void)cancelBtnClick
{
    [_pickerView hide];
}
- (NSArray *)titles
{
    return @[@"姓名",@"性别",@"出生日期",@"现居地址",@"籍贯",@"学历",@"工作年限",@"邮箱",@"手机号码",@"微信",@"自我介绍"];
}

- (NSArray *)placeHolds
{
    return @[@"请填写姓名",@"",@"",@"",@"",@"",@"",@"请填写邮箱",@"请填写手机号码",@"请填写微信"];
}
@end
