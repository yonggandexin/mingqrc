//
//  MQUpdatePartModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/23.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQHeader.h"
@class MQPosCerModel;
@interface MQUpdatePartModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger MinAge;
@property (nonatomic, assign) NSInteger MaxAge;

@property (nonatomic, copy) NSString *JobName;
@property (nonatomic, assign) NSInteger RecruitmentNumber;
@property (nonatomic, assign) NSInteger Salary;
@property (nonatomic, assign) NSInteger RequierEducation;

@property (nonatomic, copy) NSString *RequireContent;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *Mobile;
@property (nonatomic, strong) Province *WorkProvince;
@property (nonatomic, strong) City *WorkCity;
@property (nonatomic, strong) Area *WorkArea;

@property (nonatomic, copy) NSString *WorkAddress;
@property (nonatomic, strong) NSArray<MQLabelModel *> *JobWelfareIds;
@property (nonatomic, strong) NSArray <MQPosCerModel *> *JobPositionQualificationIds;
@end
