//
//  MQFullHeaderView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQFullDesModel,MQPartDesModel;
@interface MQFullHeaderView : UIView
@property (nonatomic, strong) MQFullDesModel *model;

@property (nonatomic, strong) MQPartDesModel *partModel;
@end
