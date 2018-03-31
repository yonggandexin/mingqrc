//
//  MQNewsCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/12.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQNewsCell.h"
#import "MQHeader.h"
#import "MQNewsModel.h"
@interface MQNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end
@implementation MQNewsCell


-(void)setModel:(MQNewsModel *)model
{
    _model = model;
    _titleL.text = model.Title;
    _contentL.text = model.Description;
    _timeL.text =  [self showTime:model.AddTime];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.y+=10;
    self.contentView.height-=10;
    self.contentView.x+=10;
    self.contentView.width-=20;
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.masksToBounds = YES;
}

@end
