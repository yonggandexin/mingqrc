//
//  MQLoginModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLoginModel : NSObject
//    AVATAR = "/upload/user/104D25F123254B26B9C5F3841665D13A/image/201706/23/20170623203150297356593.jpg";
//    "BIRTH_DAY" = "2017-06-23T00:00:00";
//    EMAIL = "";
//    ID = 104D25F123254B26B9C5F3841665D13A;
//    "IS_USER_AUTHENTICATION" = 1;
//    MOBILE = 18314576215;
//    "NICK_NAME" = "马强马";
//    QQ = "";
//    "REAL_NAME" = "";
//    SEX = 0;
//    SIGNATURE = "此人很懒，没有留下任何信息";
//    "USER_GRADE_ID" = CACD216E9ABC42498887DE257F858FE5;
//    "USER_NAME" = 18314576215;
//    "USER_TYPE" = 1;


@property (nonatomic, copy) NSString *AVATAR;

@property (nonatomic, copy) NSString *BIRTH_DAY;

@property (nonatomic, copy) NSString *EMAIL;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger IS_USER_AUTHENTICATION;

@property (nonatomic, assign) NSInteger IS_JOBCOMPANY_AUTH;

@property (nonatomic, assign) BOOL IS_USER_AUTH;//招聘企业认证是否成功

@property (nonatomic, copy) NSString *MOBILE;

@property (nonatomic, copy) NSString *QQ;

@property (nonatomic, copy) NSString *REAL_NAME;

@property (nonatomic, assign) NSInteger SEX;


@property (nonatomic, copy) NSString *SIGNATURE;


@property (nonatomic, copy) NSString *USER_GRADE_ID;

@property (nonatomic, copy) NSString *USER_NAME;

@property (nonatomic, assign) NSInteger USER_TYPE;

@property (nonatomic, assign) BOOL IsResume;
@end
