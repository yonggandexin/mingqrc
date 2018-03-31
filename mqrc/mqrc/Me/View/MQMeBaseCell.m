//
//  MQMeBaseCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQMeBaseCell.h"
#import "MQHeader.h"
@implementation MQMeBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.height -= 0.5;
    
}
@end
