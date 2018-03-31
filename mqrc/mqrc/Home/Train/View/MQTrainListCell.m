//
//  MQTrainListCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/6.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTrainListCell.h"
#import "MQTrainListModel.h"
#import "MQHeader.h"
@interface MQTrainListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *rightL;

@end
@implementation MQTrainListCell

- (void)setModel:(MQTrainListModel *)model
{
    _model = model;
    _timeL.text = model.Time;
    _titleL.text = model.Title;
    _rightL.text = [self showTime:model.AddTime ];
    
}

@end
