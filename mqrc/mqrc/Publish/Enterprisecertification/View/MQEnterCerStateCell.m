//
//  MQEnterCerStateCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/14.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEnterCerStateCell.h"
#import "MQCheckStateModel.h"
@interface MQEnterCerStateCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@end
@implementation MQEnterCerStateCell

- (void)setModel:(MQCheckStateModel *)model
{
    _model = model;
    
    _titleL.text = model.COMPANY_NAME;
    
    if (model.STATE_CHECK == -1) {
        [_stateBtn setBackgroundImage:[UIImage imageNamed:@"Audit failure"] forState:UIControlStateNormal];
        [_stateBtn setTitle:@"审核失败" forState:UIControlStateNormal];
    }else if (model.STATE_CHECK == 0){
        [_stateBtn setBackgroundImage:[UIImage imageNamed:@"Audit"] forState:UIControlStateNormal];
        [_stateBtn setTitle:@"审核中" forState:UIControlStateNormal];
    }else if (model.STATE_CHECK == 1){
        [_stateBtn setBackgroundImage:[UIImage imageNamed:@"pass"] forState:UIControlStateNormal];
        [_stateBtn setTitle:@"审核成功" forState:UIControlStateNormal];
    }
}

@end
