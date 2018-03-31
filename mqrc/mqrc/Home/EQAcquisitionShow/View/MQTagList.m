//
//  MQTagList.m
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTagList.h"
#import "MQHeader.h"
@implementation MQTagList

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.tagColor = mainColor;
    self.tagFont = font(9);
    self.tagCornerRadius = 2;
    self.borderColor = mainColor;
    self.borderWidth = 1;
    self.tagMargin = 4;
    self.tagButtonMargin = 2;
}
@end
