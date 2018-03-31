//
//  MQEmptTableView.m
//  mqrc
//
//  Created by 朱波 on 2017/11/29.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEmptTableView.h"
#import "MQHeader.h"
@interface MQEmptTableView()

@property (nonatomic, strong) noDataBtn *btn;

@end
@implementation MQEmptTableView
-(noDataBtn *)btn
{
    if (!_btn) {
        _btn = [noDataBtn buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake((self.width-120)*0.5, (self.height-120)*0.5-50, 135, 135);
        [_btn setImage:[UIImage imageNamed:@"ConnectionError"] forState:UIControlStateNormal];
        [_btn setTitle:@"无更多数据" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _btn;
}

- (void)setModels:(NSArray *)models
{
    _models = models;
    if (self.models.count == 0) {
        [self addSubview:self.btn];
        self.bounces = NO;
    }else{
        self.bounces = YES;
        [self.btn removeFromSuperview];
    }
}

@end

@implementation noDataBtn

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = 100;
    self.imageView.height = 100;
    self.imageView.centerX = self.width*0.5;
    self.imageView.y = 0;
    
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 25;
    self.titleLabel.y = self.height-self.titleLabel.height;
    
    self.titleLabel.font = font(13);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
