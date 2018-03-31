//
//  MQEqModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MQLabelModel;
@interface MQEqModel : NSObject


@property (nonatomic, assign) NSInteger CheckStatus;

@property (nonatomic, assign) NSInteger Clicks;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, assign) float Price;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) NSArray<MQLabelModel *> *ShareExcellence;


@property (nonatomic, copy) NSString *AddTime;



@end
