//
//  MQFullDesModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQFullDesModel : NSObject

@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, assign) NSInteger Clicks;
@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *JobSalary;
@property (nonatomic, strong) NSArray<NSString *> *JobWelfares;
@property (nonatomic, strong) NSArray<NSString *> *Qualifications;
@property (nonatomic, copy) NSString *RequireEducation;
@property (nonatomic, assign) NSInteger RecruitmentNumber;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *WorkAddress;

@property (nonatomic, copy) NSString *WorkExp;
@property (nonatomic, assign) BOOL IsSend;
@property (nonatomic, assign) BOOL IsCollect;

@property (nonatomic, copy) NSString *ShareUrl;
@property (nonatomic, strong) NSArray *CompanyQualifications;
@end
