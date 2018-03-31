//
//  MQTrainDesHeaderV.m
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTrainDesHeaderV.h"
#import "MQTrainInfoModel.h"
#import "MQHeader.h"
#import "NSString+MQHeight.h"
#define baseH 215
@interface MQTrainDesHeaderV()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *updateL;
@property (weak, nonatomic) IBOutlet UILabel *typeL;
@property (weak, nonatomic) IBOutlet UILabel *cycleTimeL;
@property (weak, nonatomic) IBOutlet UILabel *trainTimeL;
@property (weak, nonatomic) IBOutlet UILabel *dataL;
@property (weak, nonatomic) IBOutlet UILabel *desL;


@end
@implementation MQTrainDesHeaderV

- (void)setModel:(MQTrainInfoModel *)model
{
    _model = model;
    _titleL.text = model.Title;
    _updateL.text = [NSString stringWithFormat:@"更新:%@",[self showTime: model.AddTime]];
    _typeL.text = _model.WorkType;
    _cycleTimeL.text = _model.Time;
    _trainTimeL.text = _model.TimeSlot;
    _desL.text = _model.DesCription;
    
    CGSize titleSize = [model.Title strSizeWithFont:font(15)];
    CGSize desSize =[model.DesCription strSizeWithFont:font(13)];
    
    self.height = baseH+titleSize.height+desSize.height;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    [tableView reloadData];
}

@end
