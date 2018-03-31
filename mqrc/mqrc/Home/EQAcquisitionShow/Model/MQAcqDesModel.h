//
//  MQAcqDesModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQAcqDesModel : NSObject


@property (nonatomic, copy) NSString *AddTime;


@property (nonatomic, copy) NSString *Area;


@property (nonatomic, copy) NSString *City;

@property (nonatomic, assign) NSInteger Clicks;


@property (nonatomic, copy) NSString *Content;


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) NSArray *Excellence;

@property (nonatomic, copy) NSString *Industry;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Phone;

@property (nonatomic, copy) NSString *Province;

@property (nonatomic, strong) NSArray *Qualifications;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *TakeoverType;

@property (nonatomic, assign) BOOL IsCollect;

@property (nonatomic, copy) NSString *ShareUrl;
@end
