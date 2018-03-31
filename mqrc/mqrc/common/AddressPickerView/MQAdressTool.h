//
//  MQAdressTool.h
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Province;
@interface MQAdressTool : NSObject
+ (NSArray<Province *> *)getRegionModel;
@end
