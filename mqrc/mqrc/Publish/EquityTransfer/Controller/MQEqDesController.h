//
//  MQEqDesControllerViewController.h
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^desBlock) (NSString *);
@interface MQEqDesController : UIViewController


@property (nonatomic, copy) NSString *desText;
@property (nonatomic, copy) NSString *placeStr;

@property (nonatomic, copy) desBlock textBlock;

@end
