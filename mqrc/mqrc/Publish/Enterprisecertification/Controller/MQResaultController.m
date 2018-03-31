//
//  MQResaultController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQResaultController.h"
#import "MQHeader.h"
@interface MQResaultController ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation MQResaultController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"保存状态";
    _titleL.text = _desStr?_desStr:resaultStr;

}



@end
