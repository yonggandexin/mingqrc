//
//  MQAnnotationView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAnnotationView.h"
#import "MQHeader.h"
#import "MQAnnotationTitle.h"
@interface MQAnnotationView()

@property (nonatomic, strong) UIImageView *portraitImageView;

@end
@implementation MQAnnotationView
- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(10.f, 0.f, SCREEN_WIDTH-20, 80);
        _titleV = [[NSBundle mainBundle]loadNibNamed:@"MQAnnotationTitle" owner:nil options:nil][0];
        _titleV.frame = self.bounds;
        [self addSubview:_titleV];
    }
    
    return self;
}


@end
