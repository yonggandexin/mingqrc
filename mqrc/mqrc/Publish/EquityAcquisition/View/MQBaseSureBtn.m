//
//  MQBaseSureBtn.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQBaseSureBtn.h"

@implementation MQBaseSureBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"Fill"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}
@end
