//
//  MQRecruitCerCell.h
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MQRecruitCerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftW;
@end
