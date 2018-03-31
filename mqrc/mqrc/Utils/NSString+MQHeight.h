//
//  NSString+MQHeight.h
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (MQHeight)
-(CGSize)strSizeWithFont:(UIFont *)font;

- (NSMutableAttributedString *)creatAttFont:(UIFont *)font;
@end
