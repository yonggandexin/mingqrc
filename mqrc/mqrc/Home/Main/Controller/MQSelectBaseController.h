//
//  MQSelectBaseController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/22.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQHeader.h"
@interface MQSelectBaseController : MQCancelDataController
@property (nonatomic, assign) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *btns;
- (void)clickWithBtn:(UIButton *)btn;
@end

@interface MQShowBtn : UIButton



@end

