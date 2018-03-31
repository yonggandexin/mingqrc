//
//  MQFrameBaseCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/20.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFrameBaseCell.h"
#import "MQHeader.h"
@implementation MQFrameBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setChildView];
    }
    return self;
}


- (void)setChildView
{
    _backImgV = [[UIImageView alloc]init];
    _backImgV.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 50);
    [self.contentView addSubview:_backImgV];

    _starL = [UILabel new];
    _starL.text = @"*";
    _starL.textColor = [UIColor redColor];
    _starL.textAlignment = NSTextAlignmentLeft;
    _starL.width = 10;
    _starL.height = 12;
    _starL.centerX = _backImgV.x+10;
    _starL.centerY = _backImgV.centerY+2;
    [self.contentView addSubview:_starL];

    
    _titleL = [UILabel new];
    _titleL.textColor = [UIColor darkGrayColor];
    _titleL.textAlignment = NSTextAlignmentLeft;
    _titleL.font = font(13);
    _titleL.x = CGRectGetMaxX(_starL.frame);
    _titleL.y = _backImgV.y;
    _titleL.height = _backImgV.height;
    _titleL.width = 80;
    _titleL.text = @"招聘人数";
    [self.contentView addSubview:_titleL];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = baseColor;
    lineV.width = 1;
    lineV.height = 20;
    lineV.x = CGRectGetMaxX(_titleL.frame);
    lineV.centerY = _titleL.centerY;
    [self.contentView addSubview:lineV];
    
    _arrowV = [UIImageView new];
    _arrowV.width = 8;
    _arrowV.height = 15;
    _arrowV.x = CGRectGetMaxX(_backImgV.frame)-_arrowV.width-10;
    _arrowV.centerY = lineV.centerY;
    _arrowV.image = [UIImage imageNamed:@"Arrow"];
    [self.contentView addSubview:_arrowV];
    
    _contentV = [UIView new];
//    _contentV.backgroundColor = HWRandomColor;
    _contentV.x = CGRectGetMaxX(lineV.frame)+5;
    _contentV.y = 0;
    _contentV.width = _arrowV.x-_contentV.x;
    _contentV.height = _backImgV.height;
    
    [self.contentView addSubview:_contentV];
}

- (void)cellIsFirst:(BOOL)isFirst
{
    if (isFirst) {
        self.backImgV.image = [UIImage imageNamed:@"frame"];
    }else{
        self.backImgV.image = [UIImage imageNamed:@"rectangle"];
    }
}
@end
