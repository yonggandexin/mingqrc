//
//  MQTranShowModel.h
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MQLabelModel;
@interface MQTranShowModel : NSObject



@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, copy) NSString *AddTime;

@property (nonatomic, strong) NSArray <MQLabelModel *>*ShareExcellence;

@property (nonatomic, assign) NSInteger CheckStatus;

@property (nonatomic, copy) NSString *RegisteredCapital;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *ID;

@end
