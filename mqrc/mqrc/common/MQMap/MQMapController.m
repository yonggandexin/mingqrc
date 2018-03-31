//
//  MQMapController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQMapController.h"
#import "MQHeader.h"
#import "GeocodeAnnotation.h"
#import "MQAnnotationView.h"
@interface MQMapController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, strong) MQAnnotationView *poiAnnotationView;
@end

@implementation MQMapController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"详细地址";
    [self addMapView];
    
    if (_adress) {
     //根据传进来的地理位置查询经纬度
        [self searchAdress];
    }
    
    
     [MQNotificationCent addObserver:self selector:@selector(relodDesAddress:) name:SureAddres_des object:nil];

}

- (void)relodDesAddress:(NSNotification *)noti
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)addMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.zoomLevel = 15;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}


- (void)searchAdress
{//搜索位置
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = _adress;
    [self.search AMapGeocodeSearch:geo];
}


- (void)initAnnotation
{
    MAPointAnnotation *a = [[MAPointAnnotation alloc] init];
    a.coordinate = _coordinates;
    a.lockedToScreen = YES;
    a.lockedScreenPoint = CGPointMake(self.view.width*0.5, self.view.height*0.5-30);
    [self.mapView addAnnotation:a];

}
#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {

    
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *geoCellIdentifier = @"geoCellIdentifier";
        
        MQAnnotationView *poiAnnotationView = (MQAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:geoCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MQAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:geoCellIdentifier];
            poiAnnotationView.portrait = [UIImage imageNamed:@"location"];
            _poiAnnotationView = poiAnnotationView;
        }
        
        poiAnnotationView.canShowCallout = NO;
//        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
  
    AMapReGeocodeSearchRequest *request = [AMapReGeocodeSearchRequest new];
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    request.location = point;
    [self.search AMapReGoecodeSearch:request];
    XLOG(@"%f %f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [MBProgressHUD showAutoMessage:@"位置搜索错误"];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    _coordinates = [annotations[0] coordinate];
    [self.mapView setCenterCoordinate:_coordinates animated:YES];
    //搜索到位置并转换为经纬度之后添加图标
    [self initAnnotation];
}


/**
 * @brief 逆地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    AMapAddressComponent *fomat = response.regeocode.addressComponent;
    NSMutableString *adress = (NSMutableString *)response.regeocode.formattedAddress;
    
    if (fomat.township.length >0) {
        NSRange twonR = [adress rangeOfString:fomat.township];
        adress = (NSMutableString *)[adress substringFromIndex:twonR.location];
    }
    
    _poiAnnotationView.titleV.titleL.text = adress;
    
    XLOG(@"%@\n%@",fomat.township,adress);
}

@end
