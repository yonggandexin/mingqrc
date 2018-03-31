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
@implementation MQHomeNewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
   
    
}

- (void)setLsNews:(NSArray<MQNewModel *> *)lsNews
{
    _lsNews = lsNews;
    NSMutableArray *titles = [NSMutableArray array];
    [lsNews enumerateObjectsUsingBlock:^(MQNewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj.title];
    }];
    _newsView.titlesGroup = titles;
    _newsView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _newsView.onlyDisplayText = YES;
    _newsView.titleLabelTextFont = font(12);
    _newsView.titleLabelTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];;
    _newsView.titleLabelBackgroundColor = [UIColor whiteColor];
    _newsView.backgroundColor = [UIColor clearColor];
}


@end
