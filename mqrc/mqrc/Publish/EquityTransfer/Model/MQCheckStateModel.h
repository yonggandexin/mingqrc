//
//  MQCheckStateModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQCheckStateModel : NSObject
//"BUSINESS_SCOPE" = "电子商务";
//"COMPANY_NAME" = "阿里巴巴";
//"COMPANY_TYPE" = "国有企业";
//ID = D069ED8B68144C938E8AE3D1927DC17C;
//"IMG_URL" = "/upload/user/104D25F123254B26B9C5F3841665D13A/20171125114524499302366.jpg";
//LEGALREPRESENTATIVE = "朱波";
//"OPERATING_PERIOD" = "2100-10-10T00:00:00";
//PAIDCAPITAL = 6666;
//REGISTEREDCAPITAL = 8888;
//"REGISTERED_ADDRESS" = "杭州";
//REGISTRATIONDATE = "2000-10-10T00:00:00";
//"REGISTRATION_NUMBER" = 44444445;
//"STATE_CHECK" = 1;


@property (nonatomic, copy) NSString *BUSINESS_SCOPE;


@property (nonatomic, copy) NSString *COMPANY_NAME;


@property (nonatomic, copy) NSString *COMPANY_TYPE;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *IMG_URL;

@property (nonatomic, copy) NSString *LEGALREPRESENTATIVE;

@property (nonatomic, copy) NSString *OPERATING_PERIOD;

@property (nonatomic, assign) double PAIDCAPITAL;

@property (nonatomic, assign) double REGISTEREDCAPITAL;

@property (nonatomic, copy) NSString *REGISTERED_ADDRESS;

@property (nonatomic, copy) NSString *REGISTRATIONDATE;

@property (nonatomic, copy) NSString *REGISTRATION_NUMBER;

@property (nonatomic, assign) NSInteger STATE_CHECK;
@end
