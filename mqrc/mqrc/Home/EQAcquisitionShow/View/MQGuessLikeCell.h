//
//  MQGuessLikeCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQGuessLikeModel,MQEqModel,MQTranShowModel;
@interface MQGuessLikeCell : UITableViewCell
/**
 首页模型
 */
@property (nonatomic, strong) MQGuessLikeModel *model;
/**
 股权收购模型
 */
@property (nonatomic, strong) MQEqModel *eqModel;
/**
 股权转让列表模型
 */
@property (nonatomic, strong) MQTranShowModel *transModel;

@end
