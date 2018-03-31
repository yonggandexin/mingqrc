//
//  MQHomeModel.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQHomeModel.h"
#import "MQHeader.h"
@implementation MQHomeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"LsBanner":@"MQLaBannerModel",
             @"LsGuessLike":@"MQGuessLikeModel",
             @"LsNews":@"MQNewModel"
             };
}
@end
