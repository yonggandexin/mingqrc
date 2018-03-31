//
//  NSObject+MQCreatXIB.m
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "NSObject+MQCreatXIB.h"
#import <UIKit/UIKit.h>
@implementation NSObject (MQCreatXIB)
- (id)creatWithXIB:(NSString *)className{
    
    return [[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil][0];
}

@end
