//
//  MQCityController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@class City;
@interface MQCityController : UIViewController
@property (nonatomic, assign) ShareType region;
@property (nonatomic, strong) NSArray<City *> *citys;
@end
