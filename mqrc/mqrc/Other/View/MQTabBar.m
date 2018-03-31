//
//  MQTabBar.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTabBar.h"
#import "MQPublishController.h"
#import "MQHeader.h"
@interface MQTabBar()

@property (nonatomic, weak) UIButton *publishButton;

@end
@implementation MQTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [publishButton addTarget:self action:@selector(publishClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat bootom = IS_IPHONE_X?34:0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 3;
    CGFloat buttonH = self.height-bootom;
    NSInteger index = 0;
    // 设置发布按钮的frame

    self.publishButton.frame = CGRectMake(0, 0, 64, 44);
    self.publishButton.center = CGPointMake(self.width * 0.5,(self.height-bootom) * 0.5);

    // 设置其他UITabBarButton的frame
    
    for (UIView *button in self.subviews) {
        // 增加索引
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton){
            continue;
        }
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 0)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
  
}

- (void)publishClicked
{
    MQNavigationController *nv = [[MQNavigationController alloc]initWithRootViewController:[MQPublishController new]];
    [rootController presentViewController:nv animated:YES completion:nil];
}

@end
