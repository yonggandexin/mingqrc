//
//  MQNeBaseBtn.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQNeBaseBtn.h"
#import "MQHeader.h"
#define Proportion 0.6
@implementation MQNeBaseBtn

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
    self.titleLabel.font = font(13);
    [self setTitleColor:baseColor forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.height = self.height*Proportion;
    self.imageView.width = self.imageView.height;
    self.imageView.y = 0;
    self.imageView.x = (self.width-self.imageView.width)*0.5;
    
    self.titleLabel.height = self.height*(1-Proportion);
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame)+5;
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
}
@end
