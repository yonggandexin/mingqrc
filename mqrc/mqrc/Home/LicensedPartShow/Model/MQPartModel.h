//
//  MQPartModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQPartModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger RecruitmentNumber;

@property (nonatomic, copy) NSString *RequireEducation;

@property (nonatomic, copy) NSString *WorkExp;

@property (nonatomic, copy) NSString *JobSalary;

@property (nonatomic, copy) NSString *City;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *CompanyName;

@property (nonatomic, copy) NSString *AddTime;

@end
