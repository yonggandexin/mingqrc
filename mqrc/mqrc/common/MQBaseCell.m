//
//  MQBaseCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQBaseCell.h"
#import "MQHeader.h"
@interface MQBaseCell()
@property (nonatomic, strong) UIView * separatorLine;
@property (nonatomic, strong) UIView * lastLine;

@end
@implementation MQBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self buildBaseView];
    }
    return self;
}

-(void)buildBaseView
{
    _separatorLine = [UIView new];
    _separatorLine.backgroundColor = baseColor;
    _separatorLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    
    _lastLine = [UIView new];
    _lastLine.frame = CGRectZero;
    _lastLine.backgroundColor = baseColor;

    [self.contentView addSubview:_separatorLine];
    [self.contentView addSubview:_lastLine];
}

- (void)isFirst:(BOOL)isFirst andIsLast:(BOOL)isLast{
    
    if (isLast == YES) {
       _lastLine.frame = CGRectMake(0, self.contentView.height-0.5, SCREEN_WIDTH, 0.5);
    }else{
        _lastLine.frame = CGRectZero;
    }
    
}
@end
