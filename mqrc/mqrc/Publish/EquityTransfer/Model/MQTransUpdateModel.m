//
//  MQTransUpdateModel.m
//  mqrc
//
//  Created by 朱波 on 2018/1/23.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQTransUpdateModel.h"
#import "MQHeader.h"
@implementation MQTransUpdateModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Excelences":@"MQLabelModel",
             @"Qualifications":@"MQSubCerModel"
             };
}
@end
