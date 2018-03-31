//
//  MQNetBaseModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQNetBaseModel : NSObject

@property (nonatomic, copy) NSString *out_msg;

@property (nonatomic, strong) id out_bodydata;

@property (nonatomic, copy) NSString *out_timestamp;

@property (nonatomic, assign) NSInteger out_status;

@property (nonatomic, copy) NSString *out_code;
@end
