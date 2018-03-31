//
//  MQTransDesModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/4.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTransDesModel : NSObject
/*
 Transfer =     {
 AddTime = "2017/11/28 09:25:25";
 Area = "\U8354\U6e7e\U533a";
 "Business_Scope" = "\U7535\U5b50\U5546\U52a1";
 City = "\U5e7f\U5dde\U5e02";
 Clicks = 0;
 CompanyType = "\U56fd\U6709\U4f01\U4e1a";
 Content = "";
 Excellences =         (
 );
 ID = B043CB2FE9C5454A9B3B00C6CB71DA46;
 Industry = "\U5efa\U7b51\U4e1a";
 Name = "\U6731\U6ce2";
 PersonInfo = "\U53cd\U53cd\U590d\U590d\U53cd\U53cd\U590d\U590d";
 Phone = 18314576215;
 Province = "\U5e7f\U4e1c\U7701";
 Qualifications =         (
 "\U4e13\U9879\U7c7b",
 "\U7efc\U5408\U7c7b",
 "\U5de5\U7a0b\U9020\U4ef7\U54a8\U8be2\U4f01\U4e1a\U8d44\U8d28-\U4e59\U7ea7",
 "\U5de5\U7a0b\U9020\U4ef7\U54a8\U8be2\U4f01\U4e1a\U8d44\U8d28-\U7532\U7ea7"
 );
 RegisPrice = "8888.00";
 RegisTime = "2000/10/10 00:00:00";
 Title = "\U53cd\U53cd\U590d\U590d\U53cd\U590d\U65e0\U5e38";
 };
 */

@property (nonatomic, copy) NSString *Title;


@property (nonatomic, copy) NSString *RegisTime;

@property (nonatomic, copy) NSString *RegisPrice;

@property (nonatomic, strong) NSArray <NSDictionary *>*Qualifications;

@property (nonatomic, copy) NSString *Province;

@property (nonatomic, copy) NSString *City;

@property (nonatomic, copy) NSString *Area;

@property (nonatomic, copy) NSString *Phone;

@property (nonatomic, copy) NSString *PersonInfo;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Industry;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray *Excellences;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *CompanyType;
@property (nonatomic, assign) NSInteger Clicks;

@property (nonatomic, copy) NSString *BusinessScope;

@property (nonatomic, copy) NSString *AddTime;

@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, assign) BOOL IsCollect;


@property (nonatomic, copy) NSString *ShareUrl;
@end
