//
//  NSString+ZBFillSize.m
//  百思不得哥
//
//  Created by 朱波 on 2016/5/9.
//  Copyright © 2016年 朱波. All rights reserved.
//

#import "NSString+ZBFillSize.h"
#import "MQHeader.h"
@implementation NSString (ZBFillSize)


-(unsigned long long )fileSizeForFile
{

    unsigned long long size = 0;
    NSString *cachParth = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *deParth = [cachParth stringByAppendingPathComponent:self];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSArray *parths = [mgr subpathsAtPath:deParth];
    for (NSString *subParth in parths) {
        
        NSString *fillParth = [deParth stringByAppendingPathComponent:subParth];
        size += [mgr attributesOfItemAtPath:fillParth error:nil].fileSize;
        
    }
    return size;

}


-(NSString *)getCachesFileParth
{

    NSString *cachParth = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [cachParth stringByAppendingPathComponent:self];
}
@end
