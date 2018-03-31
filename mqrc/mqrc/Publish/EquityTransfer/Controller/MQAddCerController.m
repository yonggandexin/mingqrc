//
//  MQAddCerController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAddCerController.h"
#import "MQHeader.h"
#import "MQCertificateController.h"
#import "MQSubCerModel.h"
#import "MQAlreadyCerCell.h"
@interface MQAddCerController ()
<
UITableViewDelegate,
UITableViewDataSource,
TZImagePickerControllerDelegate
>

@end

@implementation MQAddCerController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"添加资质证书";

    [self initUI];
   
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    MQBaseSureBtn *leftBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"保存资质" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = font(15);
    leftBtn.frame = CGRectMake(10, SCREEN_HEIGHT-50-nav_barH, (SCREEN_WIDTH-30)*0.5, 40);
    [self.view addSubview:leftBtn];
    
    MQBaseSureBtn *rightBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = font(15);
    [rightBtn setTitle:@"添加资质" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+10, leftBtn.y, leftBtn.width, leftBtn.height);
    [self.view addSubview:rightBtn];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH-50);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerCellNibName:[MQAlreadyCerCell class]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQAlreadyCerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQAlreadyCerCell class])];
    MQSubCerModel *model = _addModels[indexPath.row];
    cell.model = model;
    cell.vc = self;
    return cell;
}
/**
 保存已选证书
 */
- (void)leftBtnClicked
{
//    if (self.addModels.count == 0) {
//        [MBProgressHUD showAutoMessage:@"请添加资质证书"];
//        return;
//    }
    _alreadyBlock(self.addModels);
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 天假证书
 */
- (void)rightBtnClicked
{
    MQCertificateController *cerVC = [MQCertificateController new];
    cerVC.addModels = _addModels;
    [cerVC setAlreadyM:^(NSArray *models) {
        _addModels = models;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:cerVC animated:YES];
}



- (NSString *)desStr
{
    return @"当前还未添加资质证书喔！";
}

- (NSString *)imgName
{
    return @"ConnectionError";
}
@end
