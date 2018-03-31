//
//  Province.h
//  UIPickerVIew_City
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//  省份模型

#import <Foundation/Foundation.h>
#import "City.h"


@interface Province : NSObject
@property (nonatomic, strong) NSString       * Name;/**< 省名字*/
@property (nonatomic, strong) NSString        * Pinyin;/**< 拼音*/
@property (nonatomic, strong) NSString * First;/**< 首字母*/
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray <City *>*Citys;

@end
