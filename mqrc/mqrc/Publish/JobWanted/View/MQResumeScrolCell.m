//
//  MQResumeScrolCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/3.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQResumeScrolCell.h"
#import "TXScrollLabelView.h"
#import "MQResaultView.h"
#import "MQSubCerModel.h"
#import "MQHeader.h"
#import "MQPosCerModel.h"
@interface MQResumeScrolCell()
<
TXScrollLabelViewDelegate
>

@end
@implementation MQResumeScrolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setCers:(NSArray *)cers
{
    _cers = cers;
    if (cers.count>0) {
        NSMutableArray *Titles = [NSMutableArray array];
        [cers enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [Titles addObject:obj.Name];
        }];
        NSString *titleStr = [Titles componentsJoinedByString:@"   "];
        TXScrollLabelView *scrollLabelView = [TXScrollLabelView scrollWithTitle:titleStr type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut];
        scrollLabelView.scrollLabelViewDelegate = self;
        scrollLabelView.frame = _superView.bounds;
        scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        scrollLabelView.scrollSpace = 10;
        scrollLabelView.font = [UIFont systemFontOfSize:14];
        scrollLabelView.textAlignment = NSTextAlignmentCenter;
        scrollLabelView.backgroundColor = [UIColor whiteColor];
        scrollLabelView.scrollTitleColor = [UIColor grayColor];
        [_superView addSubview:scrollLabelView];
        [scrollLabelView beginScrolling];
    }
    
}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{

    NSMutableArray *arr = [NSMutableArray array];
    [_cers enumerateObjectsUsingBlock:^(MQPosCerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MQSubCerModel *model = [MQSubCerModel new];
        model.ID = obj.ID;
        model.Name = obj.Name;
        [arr addObject:model];
    }];
    MQResaultView *popV = [MQResaultView show:arr];
    popV.titleL.text = @"我的证书";
    popV.btn.hidden = YES;
    popV.contentV.height-=45;
}
@end
