//
//  MQOcrBusModel.h
//  mqrc
//
//  Created by 朱波 on 2018/2/7.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQOcrBusModel : NSObject
/**
 地址
 */
@property (nonatomic, copy) NSString *Address;
/**
 经营范围
 */
@property (nonatomic, copy) NSString *Bussiness;
/**
 注册日期
 */
@property (nonatomic, copy) NSString *EstablishDate;
/**
 公司名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 法人代表名称
 */
@property (nonatomic, copy) NSString *Name;
/**
 注册号
 */
@property (nonatomic, copy) NSString *RegisNum;
/**
 营业期限
 */
@property (nonatomic, copy) NSString *EndTime;

@end
