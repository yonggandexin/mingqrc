//
//  MQDIYHeader.m
//  mqrc
//
//  Created by 朱波 on 2018/1/24.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQDIYHeader.h"
#import "UIImage+GIF.h"
#import "MQHeader.h"
@interface MQDIYHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end
@implementation MQDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 80;
    
    // 打酱油的开关
//    UISwitch *s = [[UISwitch alloc] init];
//    [self addSubview:s];
//    self.s = s;
    
    // logo
    
    UIImage *img = [UIImage sd_animatedGIFNamed:@"loading1@2x"];
    UIImageView *logo = [[UIImageView alloc] init];
//    logo.width = 80;
//    logo.height = 40;
//    logo.centerX = self.width*0.5;
//    logo.centerY = self.height*0.5;
    logo.image = img;
//    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = baseColor;
    [self addSubview:label];
    self.label = label;
    // loading
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:loading];
//    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.bounds = CGRectMake(0, 0, 125, 50);
    self.logo.center = CGPointMake(self.mj_w * 0.5,self.mj_h*0.5);
    
    self.label.x = 0;
    self.label.width = self.width;
    self.label.height = 20;
    self.label.y = CGRectGetMaxY(self.logo.frame)-10;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"释放刷新";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在刷新";
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"刷新完成";
            break;
        default:
            
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
