//
//  MQHomeTypeCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQHomeTypeCell.h"
#import "MQHeader.h"
@implementation MQHomeTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addChildViews];
        
    }
    return self;
}

- (void)addChildViews
{
    NSInteger row = self.row;
    CGFloat margin = 10;
    CGFloat board = 10;
    
    CGFloat W = (SCREEN_WIDTH-2*margin-(row-1)*board)/row;
    CGFloat H = W;
    
    for (int i = 0; i<self.totail; i++) {
        MQBaseButton *btn = [MQBaseButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.imgs[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = font(self.titleFont);
        btn.tag = i+1000;
        btn.width = W;
        btn.height = H;
        btn.x = margin+(i%row)*board+(i%row)*W;
        btn.y = (i/row)*(H+board-5)+10;
        [self.contentView addSubview:btn];
    }
}

- (void)btnClicked:(UIButton *)btn
{
    NSInteger index = btn.tag - 1000;
    if (_delegate && [_delegate respondsToSelector:@selector(goToNextFunc:)]) {
        [_delegate goToNextFunc:index];
    }
}

- (NSArray *)imgs
{
    return @[@"EnterpriseAcquisition",@"EnterpriseTransfer",@"LicensedPart_timeJob",@"FullTimeHolding",@"TalentTraining"];
}
- (NSArray *)titles
{
    return @[@"股权收购",@"股权转让",@"持证兼职",@"持证全职",@"人才培训"];
}
-(NSInteger)row
{
    return 5;
}
-(NSInteger)totail
{
    return 5;
}
-(NSInteger)titleFont
{
    return 12;
}
@end
