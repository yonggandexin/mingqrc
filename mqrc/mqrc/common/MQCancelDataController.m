//
//  MQCancelDataController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/30.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQCancelDataController.h"

@interface MQCancelDataController ()

@end

@implementation MQCancelDataController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.task cancel];
}


@end
