//
//  MQUserSetController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQUserSetController.h"
#import "MQHeader.h"
#import "MQSetBaseCell.h"
#import "MQSetNotiCell.h"
#import "MQClearCacheCell.h"
#import "MQAboutController.h"
@interface MQUserSetController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MQUserSetController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"更多";
    [self initUI];
  
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) style:UITableViewStylePlain];
    tableView.backgroundColor = baseColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerCellName:[MQSetBaseCell class]];
    [tableView registerCellName:[MQSetNotiCell class]];
    [tableView registerCellName:[MQClearCacheCell class]];
    
    UIView *footV = [UIView new];
    footV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    MQBaseSureBtn *cancelBtn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 70, SCREEN_WIDTH-20, 45);
    [cancelBtn setTitle:@"退出" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:cancelBtn];
    tableView.tableFooterView = footV;
    
}

//注销
- (void)btnClicked:(UIButton *)btn
{
    [MBProgressHUD showMessage:@"退出中..." ToView:self.navigationController.view];
    [[NetworkHelper shareInstance]postHttpToServerWithURL:API_UserLogOut withParameters:nil success:^(id res) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        [MQLoginTool updateModel];
        NSNotification *noti = [NSNotification notificationWithName:regsinLogin object:nil];
        [MQNotificationCent postNotification:noti];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 0) {
        cellID = NSStringFromClass([MQSetNotiCell class]);
    }else if (indexPath.row == 1){
        cellID = NSStringFromClass([MQClearCacheCell class]);
    } else{
        cellID = NSStringFromClass([MQSetBaseCell class]);
    }
    MQSetBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
     cell.titleL.text = self.titles[indexPath.row];
    if (indexPath.row == 0) {
        MQSetNotiCell *notiCell = (MQSetNotiCell *)cell;
        notiCell.titleL.text = self.titles[indexPath.row];
    }else if (indexPath.row == 1){
        
    } else{
        MQSetBaseCell *normalCell = (MQSetBaseCell *)cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 2){
        //跳转到APP评论界面
        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8",AppID];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
    }
   
    if(indexPath.row == 3){
        [self.navigationController pushViewController:[MQAboutController new] animated:YES];
    }
}

- (NSArray *)titles
{
    return @[@"消息提醒",@"清空缓存",@"帮助与反馈",@"关于"];
}
@end
