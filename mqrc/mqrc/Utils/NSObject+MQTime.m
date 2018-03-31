//
//  NSObject+MQTime.m
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "NSObject+MQTime.h"
#import "NSDate+MJ.h"
@implementation NSObject (MQTime)
- (NSString *)showTime:(NSString *)addTime
{
    //"ADD_TIME" = "2017/11/22 17:02:49"
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    //设置格式本地化 此处需注意
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    NSDate *created_at = [fmt dateFromString:addTime];
    
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            
            //NSLog(@"%ld--%ld--%ld",cmp.hour,cmp.minute,cmp.second);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天";
            return  [fmt stringFromDate:created_at];
            
        }else{ // 前天
            fmt.dateFormat = @"yyyy-MM-dd";
            return  [fmt stringFromDate:created_at];
        }
        
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd";
        
        return [fmt stringFromDate:created_at];
        
    }
    
    return addTime;;
    
}
@end
