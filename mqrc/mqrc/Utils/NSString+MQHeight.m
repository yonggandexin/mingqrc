//
//  NSString+MQHeight.m
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "NSString+MQHeight.h"
#import "MQHeader.h"
#import <Foundation/Foundation.h>
@implementation NSString (MQHeight)

-(CGSize)strSizeWithFont:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paragraphStyle
                          };
    CGRect rect =  [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading attributes:dic context:nil] ;
    return rect.size;
}



- (NSMutableAttributedString *)creatAttFont:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paragraphStyle
                          };
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:self];
    [att addAttributes:dic range:NSMakeRange(0, self.length)];
    return att;
}
@end
