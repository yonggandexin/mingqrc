//
//  LocaltionInstance.m
//  mqrc
//
//  Created by 王满 on 2017/6/2.
//  Copyright © 2017年 kingman. All rights reserved.
//

#import "LocaltionInstance.h"
#import <CoreLocation/CoreLocation.h>
#import "MQHeader.h"
@interface LocaltionInstance () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) NSDictionary *proviinceDic;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *areaDic;

@end

static LocaltionInstance *_instance;
@implementation LocaltionInstance

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //    XLOG(@"%s", __FUNCTION__);
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LocaltionInstance alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _province = @"";
        _provinceId = @"";
        _city = @"";
        _cityId = @"";
        _area = @"";
        _areaId = @"";
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        [self getProvinceData];
        [self findMe];
    }
    return self;
}

//- (void)getProvinceData {
//    [[NetworkHelper shareInstance] postHttpToServerWithURL:@"Universal/ProvinceCityAreaInit" withParameters:@{@"layer": @"province"} success:^(id res) {
//        _provinceArray = res[@"data"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"areaUpdate" object:@(true)];
//    } failure:^(NSString *error) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"areaUpdate" object:@(false)];
//    }];
//}
//
//- (void)getCityData {
//    [[NetworkHelper shareInstance] postHttpToServerWithURL:@"Universal/ProvinceCityAreaInit" withParameters:@{@"layer": @"city", @"pid": _provinceId} success:^(id res) {
//        _cityArray = res[@"data"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"areaUpdate" object:@(true)];
//    } failure:^(NSString *error) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"areaUpdate" object:@(false)];
//    }];
//}

- (void)findMe {
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        XLOG(@"requestAlwaysAuthorization");
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    XLOG(@"start gps");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    XLOG(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (! error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                
                // 获取城市
                NSString *city = placemark.locality;
                _province = placemark.administrativeArea;
                _city = city;
                _area = placemark.subLocality;
                
                XLOG(@"%@ %@ %@", _province, _city, _area);
//                [self getLocalId];
                NSString *province = [[NSUserDefaults standardUserDefaults] objectForKey:Now_Province];
                if (!province || ![province isEqualToString:_province]) {
                    //如果本地存储的省份数据为空或者本地存储的省份数据与当前定位的不一样
                   [[NSUserDefaults standardUserDefaults] setObject:_province forKey:Now_Province];
                }
                
            } else if ([placemarks count] == 0) {
                _province = @"定位失败";
                XLOG(@"定位城市失败");
            }
        } else {
            _province = @"定位失败";
            XLOG(@"定位城市失败");
        }
        
        NSNotification *noti = [NSNotification notificationWithName:@"relocation" object:_province];
        [MQNotificationCent postNotification:noti];
    }];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (NSString *)province
{
    NSString *province =  [[NSUserDefaults standardUserDefaults] objectForKey:Now_Province];

    return province?province:@"定位失败";
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    
}

//定位站点
//- (void)getLocalId {
//    NSDictionary *dic = @{@"L_province": [_province utf8ToUnicode], @"L_city": [_city utf8ToUnicode], @"L_area": [_area utf8ToUnicode]};
//    [[NetworkHelper shareInstance] postHttpToServerWithURL:@"Init/GetLocationInfo" withParameters:dic success:^(id res) {
//        _proviinceDic = res[@"data"][@"Province"];
//        _provinceId = _proviinceDic[@"ID"];
//        _cityDic = res[@"data"][@"City"];
//        _cityId = _cityDic[@"ID"];
//        _areaDic = res[@"data"][@"Area"];
//        _areaId = _areaDic[@"ID"];
//        _siteDic = res[@"data"][@"Site"];
//        [self getCityData];
//    } failure:^(NSString *error) {
//        ;
//    }];
//}


+ (void)getCoordinateWithAddress:(NSString *)address success:(void (^)(CLLocationDegrees, CLLocationDegrees))result failure:(void (^)(void))failure {
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            XLOG(@"%f",firstPlacemark.location.coordinate.latitude);
            XLOG(@"%f",firstPlacemark.location.coordinate.longitude);
            result(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude);
        }
        else if ([placemarks count] == 0 && error == nil) {
            XLOG(@"Found no placemarks.");
            failure();
        }
        else if (error != nil) {
            XLOG(@"An error occurred = %@", error);
            failure();
        }
    }];
}

@end
