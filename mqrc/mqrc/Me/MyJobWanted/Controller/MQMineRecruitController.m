//
//  MQMineRecruitController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/11.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMineRecruitController.h"
#import "MQMineFullRecuitController.h"
#import "MQMinePartRecuitController.h"
@interface MQMineRecruitController ()

@end

@implementation MQMineRecruitController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.topTitle;;
}

- (void)setupChildViewControllers
{

    NSString *urlStr = nil;
    if (_vcType == recuitType) {
        urlStr = API_GetJobDelivery;
    }else{
        urlStr = API_GetPublishJobList;
    }
    MQMineFullRecuitController *Takeover = [MQMineFullRecuitController new];
    Takeover.urlStr = urlStr;
    if(_vcType == JobWantedType){
        Takeover.isMine = YES;
    }
    [self addChildViewController:Takeover];
    
    MQMinePartRecuitController *transfer = [MQMinePartRecuitController new];
    transfer.urlStr = urlStr;
    if(_vcType == JobWantedType){
        transfer.isMine = YES;
    }
    [self addChildViewController:transfer];

}


- (NSArray *)titles
{
    return @[@"持证全职",@"持证兼职"];
}
@end
