//
//  MQResumeScrolCell.h
//  mqrc
//
//  Created by 朱波 on 2018/1/3.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXScrollLabelView;
@interface MQResumeScrolCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *superView;
@property (nonatomic, strong) NSArray *cers;
@end
