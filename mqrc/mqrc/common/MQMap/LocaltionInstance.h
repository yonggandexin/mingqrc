//
//  LocaltionInstance.h
//  mqrc
//
//  Created by 王满 on 2017/6/2.
//  Copyright © 2017年 kingman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocaltionInstance : NSObject

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *areaId;

@property (nonatomic, strong) NSDictionary *siteDic;

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;

+ (instancetype)shareInstance;

//根据地址获取经纬度, latitude纬度
+ (void)getCoordinateWithAddress:(NSString *)address
                         success:(void (^) (CLLocationDegrees latitude, CLLocationDegrees longitude))result
                         failure:(void (^) (void))failure;


- (void)findMe;
- (void)getProvinceData;
- (void)getCityData;

@end
