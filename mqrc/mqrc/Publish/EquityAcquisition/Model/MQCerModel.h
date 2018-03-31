//
//  MQCerModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MQSubCerModel;
@interface MQCerModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) NSArray<MQSubCerModel *> *SubTitles;

@property (nonatomic, copy) NSString *Name;
@end
