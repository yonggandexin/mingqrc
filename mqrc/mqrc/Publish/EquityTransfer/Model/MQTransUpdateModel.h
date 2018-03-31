//
//  MQTransUpdateModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/23.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQHeader.h"
@class MQSubCerModel;
@interface MQTransUpdateModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *CompanyId;

@property (nonatomic, strong) Province *Province;
@property (nonatomic, strong) City *City;
@property (nonatomic, strong) Area *Area;

@property (nonatomic, copy) NSString *IndustryId;

@property (nonatomic, copy) NSString *Personnel;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Mobile;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *Wechat;

@property (nonatomic, copy) NSString *Price;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) NSArray <MQLabelModel *>*Excelences;

@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, strong) NSArray <MQSubCerModel *> *Qualifications;
@end
