//
//  MQIqSelectedCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQIqSelectedCell.h"
@interface MQIqSelectedCell()

@property (weak, nonatomic) IBOutlet UILabel *starL;


@end
@implementation MQIqSelectedCell

- (void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    _starL.hidden = !isShow;
}

@end
