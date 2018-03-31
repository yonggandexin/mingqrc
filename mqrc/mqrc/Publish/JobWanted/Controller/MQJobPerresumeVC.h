//
//  MQJobPerresumeVC.h
//  mqrc
//
//  Created by 朱波 on 2017/12/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQResumeModel;
@interface MQJobPerresumeVC : UIViewController
@property (nonatomic, strong) NSMutableArray *lastContents;
@property (nonatomic, strong) MQResumeModel *model;
@end
