//
//  MQTrainBottomV.h
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^shareToDo) (void);
@interface MQTrainBottomV : UIView

@property (nonatomic, copy) shareToDo shareBlock;

@property (nonatomic, copy) shareToDo shareCommon;
@end
