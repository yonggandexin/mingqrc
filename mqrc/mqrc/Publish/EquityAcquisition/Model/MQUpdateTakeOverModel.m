//
//  MQUpdateTakeOverModel.m
//  mqrc
//
//  Created by 朱波 on 2018/1/22.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQUpdateTakeOverModel.h"

@implementation MQUpdateTakeOverModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Excelences":@"MQLabelModel",
             @"Qualification":@"MQSubCerModel"
             };
}
@end
