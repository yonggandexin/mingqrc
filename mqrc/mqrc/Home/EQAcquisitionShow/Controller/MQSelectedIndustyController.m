//
//  MQSelectedIndustyController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQSelectedIndustyController.h"
#import "MQHeader.h"
#import "MQIndustyModel.h"
@interface MQSelectedIndustyController ()

@end

@implementation MQSelectedIndustyController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.eqType == ShareTypeSelectedA || self.eqType == ShareTypeSelectedT) {
        UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        disBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        disBtn.bounds = CGRectMake(0, 0, 25, 25);
        [disBtn setImage:[UIImage imageNamed:@"post_dismiss"] forState:UIControlStateNormal];
        [disBtn addTarget:self action:@selector(dismissClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:disBtn];
        
        
        UIView *headV = [UIView new];
        headV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        headV.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = headV;
        
        UILabel *lable = [UILabel new];
        lable.frame = CGRectMake(13, 0, SCREEN_WIDTH-10, headV.height);
        lable.text = @"全部";
        lable.textColor = [UIColor grayColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = font(14);
        [headV addSubview:lable];
        
        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allBtn.frame = headV.bounds;
        [allBtn addTarget:self action:@selector(allBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [headV addSubview:allBtn];
    }
    
}

- (void)allBtnClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        MQIndustyModel *model = [MQIndustyModel new];
        model.ID = @"";
        model.TITLE = @"行业";
        if (self.eqType == ShareTypeSelectedA) {
            NSNotification *noti = [NSNotification notificationWithName:Selected_Aqcer object:model];
            [MQNotificationCent postNotification:noti];
        }else if (self.eqType == ShareTypeSelectedT){
            NSNotification *noti = [NSNotification notificationWithName:Selected_Trcer object:model];
            [MQNotificationCent postNotification:noti];
        }
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)dismissClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
