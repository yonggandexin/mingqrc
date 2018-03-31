//
//  MQBottomBar.m
//  mqrc
//
//  Created by 朱波 on 2017/12/18.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQBottomBar.h"
#import "MQHeader.h"
#import "MQFullBottomView.h"
@interface MQBottomBar()
@property (nonatomic, strong) HeaderBtn *btn;

@property (nonatomic, strong) BottomBtn *midBtn;

@property (nonatomic, strong) BarButton *rightBtn;
@end
@implementation MQBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addChildView];
        
    }
    return self;
}
- (void)setContactDic:(NSDictionary *)ContactDic
{
    _ContactDic = ContactDic;
    [_btn setTitle:[ContactDic objectForKey:@"Name"] forState:UIControlStateNormal];
}
- (void)addChildView
{
    
    BottomBtn *midBtn = [BottomBtn buttonWithType:UIButtonTypeCustom];
    [midBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [midBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
    [midBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [midBtn setBackgroundImage:[UIImage imageNamed:@"frame"] forState:UIControlStateNormal];
    midBtn.titleLabel.font = font(10);
    [midBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [midBtn addTarget:self action:@selector(CollectionClicked:) forControlEvents:UIControlEventTouchUpInside];
    midBtn.frame = CGRectMake(0, 0, self.height, self.height);
    [self addSubview:midBtn];
    _midBtn = midBtn;
    
    HeaderBtn *btn = [HeaderBtn buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"default_man"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(CGRectGetMaxX(midBtn.frame), 0, (self.width-midBtn.width)*0.5, self.height);
    [self addSubview:btn];
    _btn = btn;
    
    BarButton *rightBtn = [BarButton buttonWithType:UIButtonTypeCustom];
     [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = mainColor;
    [rightBtn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"打电话" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(tellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(btn.frame), 0, self.width-btn.width-midBtn.width, self.height);
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
        
}

//打电话
-(void)tellBtnClicked:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_ContactDic objectForKey:@"Phone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    });
}
//收藏
- (void)CollectionClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
@end


@implementation BarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"frame"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        self.titleLabel.font = font(14);
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = self.WH;
    self.imageView.height = self.WH;
    self.imageView.x = 20;
    self.imageView.y = (self.height-self.imageView.height)*0.5;
    
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame)+10;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width-self.titleLabel.x;
    self.titleLabel.height = self.height;
}

- (CGFloat)WH
{
    return 23;
}

@end


@implementation HeaderBtn

- (CGFloat)WH
{
    return 30;
}
@end
