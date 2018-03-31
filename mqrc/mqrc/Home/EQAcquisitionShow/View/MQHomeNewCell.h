//
//  MQHomeNewCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView,MQNewModel;
@interface MQHomeNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *newsView;
@property (nonatomic, strong) NSArray <MQNewModel *>*lsNews;
@end
