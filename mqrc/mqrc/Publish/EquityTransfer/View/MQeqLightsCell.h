//
//  MQeqLightsCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQEqHlightModel,MQJobWelfareModel;
@interface MQeqLightsCell : UITableViewCell
@property (nonatomic, strong) NSArray <MQEqHlightModel *>*hLights;
@property (nonatomic, assign) BOOL isShow;//是否必填
@property (nonatomic, strong) UILabel *lable;
//
@property (nonatomic, strong) NSArray <MQJobWelfareModel *>*obWelfares;
@end
