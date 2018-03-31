//
//  MQEqCerCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQBaseCell.h"
@class MQSubCerModel,MQPosCerModel;
@protocol MQEqCerCellDelegate<NSObject>

- (void)reloadAddData;

@end
@interface MQEqCerCell : MQBaseCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;


@property (nonatomic, weak) id<MQEqCerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (nonatomic, strong) MQSubCerModel *subModel;//股权收购证书模型
@property (nonatomic, strong) MQPosCerModel *posSerModel;
@end
