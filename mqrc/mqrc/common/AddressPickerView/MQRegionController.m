//
//  MQRegionController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRegionController.h"
#import "MQHeader.h"
#import "Province.h"
#import "BMChineseSort.h"
#import "MQCityController.h"
@interface MQRegionController ()
<
UITableViewDataSource,
UITableViewDelegate
>
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) NSArray <Province *>*regions;

@property (nonatomic, strong) HeadBtn *locationBtn;

@end

@implementation MQRegionController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MQNotificationCent addObserver:self selector:@selector(reLocation:) name:@"relocation" object:nil];
    
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    disBtn.bounds = CGRectMake(0, 0, 25, 25);
    [disBtn setImage:[UIImage imageNamed:@"post_dismiss"] forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(dismissClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:disBtn];
    
    self.navigationItem.title = @"选择省份";
    self.regions = [MQAdressTool getRegionModel];
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    self.indexArray = [BMChineseSort IndexWithArray:self.regions Key:@"Name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:self.regions Key:@"Name"];

    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.backgroundColor = baseColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerCellName:[MQBaseCell class]];
    
    UIView *headerV = [UIView new];
    headerV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
    headerV.backgroundColor = [UIColor whiteColor];
    
    HeadBtn *btn = [HeadBtn buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(12, 0, SCREEN_WIDTH, 45);
    NSString *province = [LocaltionInstance shareInstance].province;
    [btn setTitle:[NSString stringWithFormat:@"当前位置:%@",province] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(locationBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:btn];
    _locationBtn = btn;
    
    HeadBtn *allBtn = [HeadBtn buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(12, CGRectGetMaxY(btn.frame), SCREEN_WIDTH, 45);
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:allBtn];
    
    tableView.tableHeaderView = headerV;
    
}

//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArr objectAtIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province *pro = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    MQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQBaseCell class])];
    cell.textLabel.font = font(15);
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = pro.Name;
    [cell isFirst:NO andIsLast:NO];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province*pro = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (_region == ShareTypeAcquis) {
            NSNotification *noti = [NSNotification notificationWithName:Selected_city object:pro];
            [MQNotificationCent postNotification:noti];
        }else if (_region == ShareTypeTrans){
            NSNotification *noti = [NSNotification notificationWithName:Selected_TransferCity object:pro];
            [MQNotificationCent postNotification:noti];
        }
        
    }];
}

- (void)dismissClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)btnClicked
{
    Province *pro = [Province new];
    pro.ID = 0;
    pro.Name = @"全国";
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (_region == ShareTypeTrans) {
            NSNotification *noti = [NSNotification notificationWithName:Selected_TransferCity object:pro];
            [MQNotificationCent postNotification:noti];
        }else if (_region == ShareTypeAcquis){
            NSNotification *noti = [NSNotification notificationWithName:Selected_city object:pro];
            [MQNotificationCent postNotification:noti];
        }
    }];
}

- (void)locationBtnClicked
{
   
    if ([LocaltionInstance shareInstance].province) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            NSNotification *noti = [NSNotification notificationWithName:Now_Province object:[LocaltionInstance shareInstance].province];
            [MQNotificationCent postNotification:noti];
        }];
    }

    
}

- (void)reLocation:(NSNotification *)noti
{
    NSString *province = (NSString *)noti.object;
    [_locationBtn setTitle:[NSString stringWithFormat:@"当前位置:%@",province] forState:UIControlStateNormal];
}

- (void)dealloc
{
    [MQNotificationCent removeObserver:self];
}

@end

@implementation HeadBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
    self.titleLabel.font = font(15);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
