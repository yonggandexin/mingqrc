//
//  MQRegisterController.h
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,regiserType) {
    FindLoginPwd,
    registerUser
};
@interface MQRegisterController : UIViewController

@property (nonatomic, assign) regiserType desType;
@property (nonatomic, copy) NSString *des;

@end
