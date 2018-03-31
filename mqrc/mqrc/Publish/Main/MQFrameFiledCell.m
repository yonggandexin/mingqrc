//
//  MQTextFiledCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/20.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFrameFiledCell.h"
#import "MQHeader.h"
#import "MQCustomField.h"
@implementation MQFrameFiledCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView
{
    self.arrowV.hidden = YES;
    
    _contentFiled = [MQCustomField new];
    _contentFiled.frame = self.contentV.bounds;
    _contentFiled.textAlignment = NSTextAlignmentLeft;
    _contentFiled.textColor = [UIColor blackColor];
    _contentFiled.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.contentV addSubview:_contentFiled];
}

- (void)setPlaceStr:(NSString *)placeStr
{
    _contentFiled.placeholder = placeStr;
}

@end
