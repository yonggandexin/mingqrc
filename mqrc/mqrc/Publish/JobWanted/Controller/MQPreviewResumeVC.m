//
//  MQPreviewResumeVC.m
//  mqrc
//
//  Created by 朱波 on 2018/1/2.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQPreviewResumeVC.h"
#import "MQHeader.h"
#import "MQResumeView.h"
#import "MQResumeModel.h"
#import "MQJobWantedController.h"
@interface MQPreviewResumeVC ()
@property (nonatomic, strong) MQResumeView *scrollV;
@end

@implementation MQPreviewResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_isCreatResume == NO){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = font(15);
        btn.frame = CGRectMake(0, 0, 50, 35);
        [btn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    self.navigationItem.title = @"我的简历";
    UIImageView *backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backImgView.image = [UIImage imageNamed:@"ResumeBackground"];
    [self.view addSubview:backImgView];

    MQResumeView *scrollV = [[MQResumeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:scrollV];
    _scrollV = scrollV;

    [self loadData];
}

- (void)loadData
{
    [self showHudWithTitle:@"加载中..."];
    self.task = [[NetworkHelper shareInstance]postHttpToServerWithURL:API_GetUserResume withParameters:nil success:^(id res) {
        [self hideHudVCview];
        MQResumeModel *model = [MQResumeModel mj_objectWithKeyValues:res];
        _scrollV.model = model;
    } failure:^(id error) {
        [self hideHudVCview];
    }];
}

- (void)editClicked:(UIButton *)btn
{
    if (_scrollV.model) {
        MQJobWantedController *vc = [MQJobWantedController new];
        vc.model = _scrollV.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)dealloc
{
    [self hideHudVCview];
}
@end
