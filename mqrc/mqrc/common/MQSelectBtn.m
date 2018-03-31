//
//  MQSelectBtn.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQSelectBtn.h"
#import "MQHeader.h"
@implementation MQSelectBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    self.titleLabel.font = font(DPH(13));
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.height = 8;
    self.imageView.width = 10;
    self.imageView.y = (self.height-self.imageView.height)*0.5;
    self.imageView.x = self.width-47;
    
    self.titleLabel.height = self.height;
    self.titleLabel.y = 0;
    self.titleLabel.x = 2;
    self.titleLabel.width = self.imageView.x;
}
@end
