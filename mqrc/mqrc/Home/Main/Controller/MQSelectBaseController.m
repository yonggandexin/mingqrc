//
//  MQSelectBaseController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQSelectBaseController.h"
#import "MQHeader.h"
@interface MQSelectBaseController ()

@end

@implementation MQSelectBaseController
- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor grayColor];
    backView.x = 0;
    backView.y = 0;
    backView.width = SCREEN_WIDTH;
    backView.height = 36;
    [self.view addSubview:backView];

    for (int i = 0; i < self.titles.count; i++) {
        MQShowBtn *btn = [MQShowBtn buttonWithType:UIButtonTypeCustom];
        btn.width = SCREEN_WIDTH/self.titles.count;
        btn.height = backView.height-0.5;
        btn.x = i*btn.width;
        btn.y = 0;
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [backView addSubview:btn];
        [self.btns addObject:btn];
        if (i!=self.titles.count-1) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor grayColor];
            line.width = 0.5;
            line.height = btn.height;
            line.x = btn.width-line.width;
            line.y = 0;
            [btn addSubview:line];
        }
        
    }
}


- (void)btnClicked:(UIButton *)btn
{
    [self clickWithBtn:btn];
}

- (void)clickWithBtn:(UIButton *)btn
{
    
}
@end

@implementation MQShowBtn
- (instancetype)initWithFrame:(CGRect)frame
{
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
    [self setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = font(11);
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.width = 9;
    self.imageView.height = 8;
    self.imageView.x = self.width-self.imageView.width-5;
    self.imageView.y = (self.height-self.imageView.height)*0.5;

    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    self.titleLabel.height = self.height;
    self.titleLabel.width = self.imageView.x;

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end

