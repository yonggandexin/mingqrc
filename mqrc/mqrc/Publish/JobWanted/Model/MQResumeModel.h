//
//  MQResumeModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/3.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MQPosCerModel,MQLabelModel,Province,City;
@interface MQResumeModel : NSObject
@property (nonatomic, copy) NSString *BirthDay;

@property (nonatomic, copy) NSString *JobType;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *Wechat;

@property (nonatomic, copy) NSString *HomeTown;

@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, copy) NSString *LiveAddress;

@property (nonatomic, copy) NSString *MaxEducation;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Phone;

@property (nonatomic, strong) MQLabelModel *Position;

@property (nonatomic, strong) NSArray <MQPosCerModel *>*Qualicafitions;

@property (nonatomic, copy) NSString *ResumeID;

@property (nonatomic, assign) NSInteger Salary;

@property (nonatomic, copy) NSString *Sex;

@property (nonatomic, copy) NSString *StateCheck;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) City *WorkCity;

@property (nonatomic, strong) Province *WorkProvince;

@property (nonatomic, assign) NSInteger WorkTime;

@property (nonatomic, copy) NSString *Des;
@end
