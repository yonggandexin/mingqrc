//
//  MQMineRecruitController.h
//  mqrc
//
//  Created by 朱波 on 2018/1/11.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQMyCollectController.h"
typedef NS_ENUM(NSUInteger,mineType) {
    JobWantedType,//我的招聘
    recuitType //我的求职
    
};
@interface MQMineRecruitController : MQMyCollectController

@property (nonatomic, copy) NSString *topTitle;

@property (nonatomic, assign) mineType vcType;
@end
