//
//  MQTrainBottomV.m
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTrainBottomV.h"
@interface MQTrainBottomV()

- (IBAction)commonBtnClicked:(id)sender;

- (IBAction)shareClicked:(id)sender;

@end
@implementation MQTrainBottomV

- (IBAction)commonBtnClicked:(id)sender
{
    _shareCommon();
}

- (IBAction)shareClicked:(id)sender
{
   _shareBlock(); 
}

@end
