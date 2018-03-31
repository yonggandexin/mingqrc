//
//  MQAdressTool.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAdressTool.h"
#import "MQHeader.h"
#import "Province.h"
@implementation MQAdressTool
+ (NSArray<Province *> *)getRegionModel
{
   return [[[self class] new] loadAddressData];
}

- (NSArray<Province *> *)loadAddressData{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"city"
                                                          ofType:@"txt"];
    
    NSError  * error;
    NSString * str22 = [NSString stringWithContentsOfFile:filePath
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    
    if (error) {
        return nil;
    }
    
    NSArray *dttArr = [self dictionaryWithJsonString:str22];
    
    if (!dttArr) {
        return nil;
    }
    
    NSMutableArray *pArr         = [[NSMutableArray alloc]init];
    [dttArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Province *p = [Province mj_objectWithKeyValues:obj];
        [pArr addObject:p];
    }];
    return pArr;
}


- (NSArray *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSArray * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
    if(err) {
        XLOG(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
