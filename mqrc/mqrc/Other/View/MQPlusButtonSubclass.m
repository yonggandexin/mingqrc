//
//  MQPlusButtonSubclass.m
//  mqrc
//
//  Created by 朱波 on 2018/1/9.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQPlusButtonSubclass.h"
#import "MQHeader.h"
#import "MQPublishController.h"
@interface MQPlusButtonSubclass()
{
    CGFloat _buttonImageHeight;
}

@end
@implementation MQPlusButtonSubclass

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
  
}


+ (id)plusButton {
    MQPlusButtonSubclass *button = [[MQPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"Release"];
    [button setImage:buttonImage forState:UIControlStateNormal];
//    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
//    [button setTitle:@"发布" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9];
    //[button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    button.bounds = CGRectMake(0.0, 0.0, 100, 100);
   
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)clickPublish {
    
    MQNavigationController *nv = [[MQNavigationController alloc]initWithRootViewController:[MQPublishController new]];
    [rootController presentViewController:nv animated:YES completion:nil];

}


+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  3;
}
@end
