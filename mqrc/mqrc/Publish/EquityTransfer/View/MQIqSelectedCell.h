//
//  MQIqSelectedCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@class MQCustomLable;
@interface MQIqSelectedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet MQCustomLable *contentL;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *iqTextFiled;
@property (nonatomic, assign) BOOL isShow;//是否必填
@property (weak, nonatomic) IBOutlet UIImageView *rightV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightW;

@end
