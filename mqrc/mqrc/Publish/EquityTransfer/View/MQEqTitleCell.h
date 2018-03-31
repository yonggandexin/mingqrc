//
//  MQEqTitleCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQCustomField;
@interface MQEqTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet MQCustomField *contentT;
@property (weak, nonatomic) IBOutlet UIImageView *backImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isShow;//是否必填
@end
