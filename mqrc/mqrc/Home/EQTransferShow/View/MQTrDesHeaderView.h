//
//  MQTrDesHeaderView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQTransDesModel;
@interface MQTrDesHeaderView : UIView
@property (nonatomic, strong) MQTransDesModel *model;
@property (nonatomic, strong) UIViewController *superVC;
@end
