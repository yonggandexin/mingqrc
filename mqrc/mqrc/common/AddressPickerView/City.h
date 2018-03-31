//
//  City.h
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/13.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Area;
@interface City : NSObject

@property (nonatomic, strong) NSString       * Name;/**< 市名字*/
@property (nonatomic, strong) NSString        * Pinyin;/**< 拼音*/
@property (nonatomic, strong) NSString * First;/**< 首字母*/
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray <Area *>*Areas;


@end
