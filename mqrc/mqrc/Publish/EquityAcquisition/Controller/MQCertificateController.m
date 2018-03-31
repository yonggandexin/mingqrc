//
//  MQCertificateController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQCertificateController.h"
#import "MQHeader.h"
#import "MQIndustyModel.h"
#import "MQCerModel.h"
#import "MQEqCerCell.h"
#import "MQSubCerModel.h"
@interface MQCertificateController ()
<
UITableViewDelegate,
UITableViewDataSource,
MQEqCerCellDelegate
>
{
    int _folder[2000];
}
@property (nonatomic, strong) NSMutableArray <MQCerModel *>*sections;
@property (nonatomic, strong) UITableView *tableView;
@end
#define sectionH 40
@implementation MQCertificateController
#pragma mark -Lazy
- (NSMutableArray <MQCerModel *>*)sections
{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}
#pragma mark -Super
#pragma mark -Init
#pragma mark -Server
#pragma mark -Delegate
#pragma mark -Staus
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资质证书";
    
    [self loadData];
    
    [self initUI];
}

- (void)loadData
{
    [MBProgressHUD showMessage:@"加载中..." ToView:self.navigationController.view];
    NSDictionary *pram = @{
                           @"industryId":industry_ID
                           };
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_getSharesTakeOverQualificationType withParameters:pram success:^(id res) {
        NSArray *addArr = [res objectForKey:@"data"];
        [addArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MQCerModel *model = [MQCerModel mj_objectWithKeyValues:obj];
            [self.sections addObject:model];
        }];
        
        [self showAlreadyData];
        
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
    
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerCellNibName:[MQEqCerCell class]];
    MQBaseSureBtn *btn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, SCREEN_HEIGHT-50-nav_barH, SCREEN_WIDTH-20, 40);
    [btn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    获取图片名字
    NSString *imageName = _folder[section] == 1? @"expansion":@"open";
    
    //    存储图片信息
    UIImage *image = [UIImage imageNamed:imageName];
    static NSString *sectionID = @"sectionID";
    UITableViewHeaderFooterView *sectionV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionID];
    if (!sectionV) {
        sectionV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:sectionID];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 7.5, 20, 20)];
        sectionV.contentView.backgroundColor = baseColor;
        [sectionV.contentView addSubview:imgView];
        
        UILabel *titleL = [UILabel new];
        titleL.frame = CGRectMake(10, 0, SCREEN_WIDTH-50, sectionH);
        titleL.font = font(15);
        titleL.tag = 1001;
        titleL.textColor = [UIColor blackColor];
        [sectionV.contentView addSubview:titleL];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, sectionH);
        [sectionV.contentView addSubview:btn];
    }
    
    MQCerModel *model = self.sections[section];
    for (UIView *view in sectionV.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]] && view.tag == 1001) {
            UILabel *lable = (UILabel *)view;
            lable.text = model.Name;
        }
        
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton *)view).tag = 500+section;
        }
        
        if ([view isKindOfClass:[UIImageView class]]) {
            ((UIImageView *)view).image = image;
        }
    }
    
    return sectionV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MQCerModel *model = self.sections[section];
    if (_folder[section] != 0) {
        return 0;
    }
    return model.SubTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQEqCerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQEqCerCell class])];
    cell.delegate = self;
    MQCerModel *model = self.sections[indexPath.section];
    MQSubCerModel *subModel = model.SubTitles[indexPath.row];
    cell.subModel = subModel;
    return cell;
}



- (void)reloadAddData
{
    [_tableView reloadData];
}



- (void)btnClicked:(UIButton *)btn
{
    NSInteger section = btn.tag-500;
    _folder[section]^=1;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)finishBtnClicked:(UIButton *)btn
{
    NSMutableArray *addModels = [NSMutableArray array];
    [self.sections enumerateObjectsUsingBlock:^(MQCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.SubTitles enumerateObjectsUsingBlock:^(MQSubCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            if (obj.isAdd == YES) {
                [addModels addObject:obj];
            }
        }];
    }];
  
    _alreadyM(addModels);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlreadyData
{
    NSMutableArray <MQSubCerModel *>*subArr = [NSMutableArray array];
    [self.sections enumerateObjectsUsingBlock:^(MQCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.SubTitles enumerateObjectsUsingBlock:^(MQSubCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [subArr addObject:obj];
        }];
    }];
    
    [subArr enumerateObjectsUsingBlock:^(MQSubCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_addModels enumerateObjectsUsingBlock:^(MQSubCerModel *  _Nonnull alModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([alModel.ID isEqualToString:obj.ID]) {
                obj.isAdd = YES;
                if (alModel.ImgUrl) {
//                    obj.img = alModel.img;
                    obj.ImgUrl = alModel.ImgUrl;
                }
            }
        }];
    }];
}
@end
