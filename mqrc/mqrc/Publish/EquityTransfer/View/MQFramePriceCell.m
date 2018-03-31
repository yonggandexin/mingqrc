//
//  MQFramePriceCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/21.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFramePriceCell.h"
#import "MQHeader.h"
#import "MQCustomField.h"
@implementation MQFramePriceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self initContentV];
        
    }
    return self;
}

- (void)initContentV
{
    
    self.arrowV.width = 0;
    UILabel *unitL = [UILabel new];
    unitL.textColor = mainColor;
    unitL.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];;
    unitL.textAlignment = NSTextAlignmentRight;
    unitL.text = @"万元";
    unitL.width = 30;
    unitL.height = self.contentV.height;
    unitL.y = 0;
    unitL.x = self.contentV.width-unitL.width;
    [self.contentV addSubview:unitL];
    
    _contentFiled = [MQCustomField new];
    _contentFiled.textAlignment = NSTextAlignmentCenter;
    _contentFiled.borderStyle = UITextBorderStyleRoundedRect;
    _contentFiled.keyboardType = UIKeyboardTypeNumberPad;
    _contentFiled.width = 80;
    _contentFiled.height = 30;
    _contentFiled.x = self.contentV.width-unitL.width-_contentFiled.width-10;
    _contentFiled.centerY = self.contentV.centerY;
    [self.contentV addSubview:_contentFiled];
    
}

@end
