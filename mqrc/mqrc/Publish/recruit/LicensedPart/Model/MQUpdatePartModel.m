//
//  MQUpdatePartModel.m
//  mqrc
//
//  Created by 朱波 on 2018/1/23.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQUpdatePartModel.h"

@implementation MQUpdatePartModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"JobWelfareIds":@"MQLabelModel",
             @"JobPositionQualificationIds":@"MQPosCerModel"
             };
}
@end
