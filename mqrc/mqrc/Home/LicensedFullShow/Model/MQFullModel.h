//
//  MQFullModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQFullModel : NSObject
/*
 AddTime = "2017/12/20 15:33:48";
 CompanyName = "\U4e2d\U56fd\U77f3\U6cb9\U96c6\U56e2";
 ID = 0D06B01C452B4EA78559B0E30B7B0ED4;
 JobSalary = "8000-12000\U5143";
 JobType = 2;
 RecruitmentNumber = 5;
 RequireEducation = "";
 Title = "\U62db\U8058\U5efa\U9020\U5e08";
 WorkExp = "";
 */


@property (nonatomic, copy) NSString *AddTime;

@property (nonatomic, copy) NSString *CompanyName;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *JobSalary;

@property (nonatomic, assign) NSInteger RecruitmentNumber;

@property (nonatomic, copy) NSString *RequireEducation;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *WorkExp;

@property (nonatomic, strong) NSArray *JobWelfares;

@property (nonatomic, copy) NSString *City;

@end
