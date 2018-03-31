//
//  Area.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject
@property (nonatomic, strong) NSString       * Name;/**< 区名字*/
@property (nonatomic, strong) NSString        * Pinyin;/**< 拼音*/
@property (nonatomic, strong) NSString * First;/**< 首字母*/
@property (nonatomic, assign) NSInteger ID;

@end
