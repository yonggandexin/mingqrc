//
//  MQEqCerCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEqCerCell.h"
#import "MQSubCerModel.h"
#import "MQPosCerModel.h"
@interface MQEqCerCell()

- (IBAction)selectedClicked:(id)sender;
@end
@implementation MQEqCerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSubModel:(MQSubCerModel *)subModel
{
    _subModel = subModel;
    _contentL.text = subModel.Name;
    NSString *imgN = subModel.isAdd == YES?@"righeblue":@"right";
    _rightImgV.image = [UIImage imageNamed:imgN];
}

- (IBAction)selectedClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (_subModel) {
        _subModel.isAdd = sender.selected;
        if (_delegate &&[_delegate respondsToSelector:@selector(reloadAddData)]) {
            [_delegate reloadAddData];
        }
    }
    
    if (_posSerModel) {
        _posSerModel.isAdd = sender.selected;
        if (_delegate &&[_delegate respondsToSelector:@selector(reloadAddData)]) {
            [_delegate reloadAddData];
        }
    }
    

}

- (void)setPosSerModel:(MQPosCerModel *)posSerModel
{
    _posSerModel = posSerModel;
    _contentL.text = posSerModel.Name;
    NSString *imgN = posSerModel.isAdd == YES?@"righeblue":@"right";
    _rightImgV.image = [UIImage imageNamed:imgN];
}
@end
