//
//  MQPostionStyleController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/15.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQLabelModel;
typedef void(^posationBlock) (MQLabelModel *,MQLabelModel *);
@interface MQPostionStyleController : UIViewController

@property (nonatomic, copy) posationBlock modelBlock;
@end
