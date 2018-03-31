//
//  MQPartDesModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQPartDesModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger RecruitmentNumber;

@property (nonatomic, copy) NSString *RequireEducation;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *JobSalary;

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, strong) NSArray<NSString *> *Qualifications;

@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, assign) NSInteger Clicks;
@property (nonatomic, copy) NSString *WorkAddress;
@property (nonatomic, assign) BOOL IsCollect;
@property (nonatomic, assign) BOOL IsSend;
@property (nonatomic, copy) NSString *ShareUrl;
@property (nonatomic, strong) NSArray *CompanyQualifications;
@end
