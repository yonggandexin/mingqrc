//
//  UIView+MQExtension.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "UIView+MQExtension.h"

@implementation UIView (MQExtension)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}



- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setcenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setcenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/*
 -(CGFloat) centerX {
 return self.center.x;
 }
 
 -(void)setCenterX:(CGFloat)centerX {
 self.center=CGPointMake(centerX, self.centerY);
 }
 
 -(CGFloat) centerY {
 return self.center.y;
 }
 
 -(void)setCenterY:(CGFloat)centerY {
 self.center=CGPointMake(self.centerX,centerY);
 }
*/

- (CGFloat)right
{
    //    return self.x + self.width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom
{
    //    return self.y + self.height;
    return CGRectGetMaxY(self.frame);
}

- (void)setright:(CGFloat)right
{
    self.x = right - self.width;
}

- (void)setbottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}
@end
