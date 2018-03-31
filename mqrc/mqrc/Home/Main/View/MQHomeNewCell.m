//
//  MQHomeNewCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQHomeNewCell.h"
#import "SDCycleScrollView.h"
#import "MQHeader.h"
#import "MQNewModel.h"
#import "TXScrollLabelView.h"
@interface MQHomeNewCell()<TXScrollLabelViewDelegate>
@property (nonatomic, strong) UIImageView *leftImgV;
@property (nonatomic, strong) UIView *line;
@end
@implementation MQHomeNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIImageView *leftImgV = [[UIImageView alloc]init];
    leftImgV.image = [UIImage imageNamed:@"MingQiTouTiao"];
    leftImgV.x = 10;
    leftImgV.width = 60;
    leftImgV.height = 20;
    leftImgV.centerY = self.contentView.height*0.5-5;
    [self.contentView addSubview:leftImgV];
    _leftImgV = leftImgV;
    
    UIView *line = [UIView new];
    line.x = CGRectGetMaxX(leftImgV.frame)+10;
    line.width = 1;
    line.height = 20;
    line.centerY = leftImgV.centerY;
    line.backgroundColor = baseColor;
    [self.contentView addSubview:line];
    _line = line;
    
}

- (void)setLsNews:(NSArray<MQNewModel *> *)lsNews
{
    _lsNews = lsNews;
    
    for (UIView *subV in self.contentView.subviews) {
        if ([subV isKindOfClass:[TXScrollLabelView class]]) {
            [subV removeFromSuperview];
        }
    }
    NSMutableArray *titles = [NSMutableArray array];
    [lsNews enumerateObjectsUsingBlock:^(MQNewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj.Title];
    }];
    
    TXScrollLabelView *newsView = [TXScrollLabelView scrollWithTextArray:titles type:TXScrollLabelViewTypeFlipNoRepeat velocity:2 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    newsView.scrollLabelViewDelegate = self;
    newsView.x = CGRectGetMaxX(_line.frame)+10;
    newsView.y = 0;
    newsView.width = self.contentView.width-newsView.x-10;
    newsView.height = self.contentView.height;
    newsView.scrollSpace = 5;
    newsView.textAlignment = NSTextAlignmentLeft;
    newsView.font = [UIFont systemFontOfSize:13];
    newsView.backgroundColor = [UIColor whiteColor];
    newsView.scrollTitleColor = [UIColor blackColor];
    [self.contentView addSubview:newsView];
    [newsView beginScrolling];

}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    
    MQNewModel *model = self.lsNews[index];
    _newsClick(model);
    XLOG(@"%@--%ld",text, index);
}
@end
