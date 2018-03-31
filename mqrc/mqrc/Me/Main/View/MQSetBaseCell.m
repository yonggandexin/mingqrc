//
//  MQSetBaseCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/15.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQSetBaseCell.h"
#import "MQHeader.h"
@implementation MQSetBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.width = 8;
    imgV.height = 15;
    imgV.x = SCREEN_WIDTH-imgV.width-10;
    imgV.centerY = self.contentView.centerY;
    imgV.image = [UIImage imageNamed:@"Arrow"];
    [self.contentView addSubview:imgV];
    self.imgV = imgV;
    
    _titleL = [UILabel new];
    _titleL.textAlignment = NSTextAlignmentLeft;
    _titleL.textColor = [UIColor grayColor];
    _titleL.font = font(15);
    _titleL.x = 10;
    _titleL.y = 0;
    _titleL.height = self.contentView.height;
    _titleL.width = 150;
    [self.contentView addSubview:_titleL];
}
@end
