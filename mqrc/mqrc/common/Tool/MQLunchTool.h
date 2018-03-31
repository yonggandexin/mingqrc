//
//  MQLunchTool.h
//  mqrc
//
//  Created by 朱波 on 2018/1/24.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLunchTool : NSObject

@property (nonatomic, copy) NSString *imgBaseUrl;
+ (instancetype)shareInstance;
- (void)getAPPBaseData;




@end
