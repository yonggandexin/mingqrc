//
//  MQPreviewResumeVC.h
//  mqrc
//
//  Created by 朱波 on 2018/1/2.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQCancelDataController.h"
@interface MQPreviewResumeVC : MQCancelDataController
/**
 YES：创建简历 NO：预览简历
 */
@property (nonatomic, assign) BOOL isCreatResume;
@end
