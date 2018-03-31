//
//  MQResumeModel.m
//  mqrc
//
//  Created by 朱波 on 2018/1/3.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQResumeModel.h"
#import "MQHeader.h"
#import "MQPosCerModel.h"
@implementation MQResumeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Qualicafitions":@"MQPosCerModel"
             
             };
}


@end
