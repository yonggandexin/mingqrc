//
//  MQFullShowCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFullShowCell.h"
#import "MQHeader.h"
#import "MQFullModel.h"
#import "MQTagList.h"
@interface MQFullShowCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *educationL;
@property (weak, nonatomic) IBOutlet UILabel *regionL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet MQTagList *listView;
@property (weak, nonatomic) IBOutlet UILabel *experenceL;

@end
@implementation MQFullShowCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (void)setModel:(MQFullModel *)model
{
    _model = model;
    _titleL.text = model.Title;
    _timeL.text = [self showTime: model.AddTime];
    NSInteger nums = 0;
    if(IS_IPHONE5){
        nums = 4;
    }else if (IS_IPHONE6){
        nums = 5;
    }else{
        nums = 6;
    }
    if (model.JobWelfares.count>nums) {
      NSArray *arr = [model.JobWelfares subarrayWithRange:NSMakeRange(0, nums)];
        NSMutableArray *fareArr = [NSMutableArray arrayWithArray:arr];
        [fareArr addObject: @"..."];
        [_listView deleteTags:fareArr];
        [_listView addTags:fareArr];
    }else{
        [_listView deleteTags:model.JobWelfares];
        [_listView addTags:model.JobWelfares];
    }
    _regionL.text = model.City;
    _educationL.text = model.RequireEducation;
    _experenceL.text = model.WorkExp;
   
    _salaryL.text = model.JobSalary;
}




@end

@implementation FullBtn
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = 13;
    self.imageView.height = 13;
    self.imageView.x = 0;
    self.imageView.centerY = self.height*0.5;
    
    self.titleLabel.x = self.imageView.width+2;
}
@end
