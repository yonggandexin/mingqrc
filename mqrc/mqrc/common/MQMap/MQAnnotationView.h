//
//  MQAnnotationView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MQAnnotationTitle.h"
@class MQAnnotationTitle;
@interface MQAnnotationView : MAAnnotationView
@property (nonatomic, strong) UIImage *portrait;
@property (nonatomic, strong) MQAnnotationTitle *titleV;
@end
