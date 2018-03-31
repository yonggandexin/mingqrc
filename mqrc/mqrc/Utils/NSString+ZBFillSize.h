//
//  NSString+ZBFillSize.h
//  百思不得哥
//
//  Created by 朱波 on 2016/5/9.
//  Copyright © 2016年 朱波. All rights reserved.
// 计算文件夹大小

#import <Foundation/Foundation.h>

@interface NSString (ZBFillSize)

-(unsigned long long )fileSizeForFile;

-(NSString *)getCachesFileParth;

@end
