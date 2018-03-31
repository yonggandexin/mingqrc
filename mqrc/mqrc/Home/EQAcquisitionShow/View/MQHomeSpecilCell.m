//
//  MQHomeSpecilCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQHomeSpecilCell.h"

@implementation MQHomeSpecilCell

- (NSArray *)imgs
{
    return @[@"Hotel",@"Bar",@"Restaurant",@"KTV",@"House",@"Entertainment",@"Expand",@"Train",@"Agritainment",@"Scenicspot"];
}
- (NSArray *)titles
{
    return @[@"酒店",@"酒吧",@"餐厅",@"KTV",@"轰趴",@"娱乐场所",@"拓展中心",@"培训中心",@"特色农家",@"著名景区"];
}
-(NSInteger)row
{
    return 5;
}
-(NSInteger)totail
{
    return 10;
}

-(NSInteger)titleFont
{
    return 12;
}
@end
