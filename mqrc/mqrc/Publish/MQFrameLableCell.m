//
//  MQFrameLableCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/20.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFrameLableCell.h"

@implementation MQFrameLableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self initContentV];
        
        
    }
    return self;
}

- (void)initContentV
{
    _contentL = [UILabel new];
    _contentL.frame = self.contentV.bounds;
    _contentL.textColor = [UIColor blackColor];
    _contentL.textAlignment = NSTextAlignmentLeft;
    _contentL.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.contentV addSubview:_contentL];
    
}
@end
