//
//  MQUpdateTakeOverModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/22.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQHeader.h"
@class MQSubCerModel;
@interface MQUpdateTakeOverModel : NSObject
@property (nonatomic, strong) Province *Province;
@property (nonatomic, strong) City *City;
@property (nonatomic, strong) Area *Area;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *Email;
@property (nonatomic, strong) NSArray <MQLabelModel *>*Excelences;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *IndustryId;

@property (nonatomic, copy) NSString *IntentionPrice;

@property (nonatomic, copy) NSString *Mobile;

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, strong) NSArray <MQSubCerModel *>*Qualification;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Wechat;

@end
