//
//  MQPartShowCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPartShowCell.h"
#import "MQPartModel.h"
#import "MQHeader.h"
@interface MQPartShowCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *regionL;
@property (weak, nonatomic) IBOutlet UILabel *educationL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end
@implementation MQPartShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MQPartModel *)model
{
    _model = model;
    _titleL.text = model.Title;
    _regionL.text = model.City;
    _educationL.text = model.RequireEducation;
    _numL.text = [NSString stringWithFormat:@"%zd人",model.RecruitmentNumber];
    _salaryL.text = model.JobSalary;
    _timeL.text = [self showTime:model.AddTime];
}
@end
