//
//  MQAlreadyCerCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQSubCerModel,MQAddCerController;
@interface MQAlreadyCerCell : UITableViewCell

@property (nonatomic, strong) MQSubCerModel *model;
@property (nonatomic, strong) MQAddCerController *vc;
@end
