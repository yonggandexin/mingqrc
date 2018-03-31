//
//  MQMeFooterView.m
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMeFooterView.h"
#import "MQHeader.h"
@interface MQMeFooterView()

@property (nonatomic, strong) NSArray *Titles;
@property (nonatomic, strong) NSArray *images;

@end
@implementation MQMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    for (int i = 0; i<self.Titles.count; i++) {
        mqMeFooterBtn *btn = [mqMeFooterBtn buttonWithType:UIButtonTypeCustom];
        NSInteger row = 3;
        NSInteger board = 1;
        btn.width = (SCREEN_WIDTH - (row+1)*board)/row;
        btn.height = btn.width;
        btn.x = board + (i%3)*(btn.width+board);
        btn.y = board + (i/3)*(btn.width+board);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [btn setTitle:self.Titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self addSubview:btn];
    }
}
- (NSArray *)Titles
{
    return @[@"我的收藏",@"我的收购",@"我的转让",@"我的招聘",@"我的求职",@"企业认证"];
}

- (NSArray *)images
{
    return @[@"MyCollection",@"MyAcquisition",@"MyTransfer",@"MyRecruitment",@"MyJobJearch",@"EnterpriseCertification"];
}

- (void)btnClicked:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickWithIndex:)]) {
        [_delegate clickWithIndex:btn.tag];
    }
}
@end

//mqMeFooterBtn
@implementation mqMeFooterBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 25;
    self.titleLabel.y = self.height-35;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = font(12);
    
    self.imageView.centerX = self.width*0.5;
    self.imageView.centerY = self.height*0.5-10;
}


@end
