//
//  MQLsBannerView.m
//  mqrc
//
//  Created by 朱波 on 2018/1/25.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQLsBannerView.h"
#import "MQHeader.h"
#import "MQLaBannerModel.h"
@interface MQLsBannerView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *sdView;

@end
@implementation MQLsBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    SDCycleScrollView *sdView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
    [self addSubview:sdView];
    _sdView = sdView;
}

- (void)setLsBanner:(NSArray<MQLaBannerModel *> *)LsBanner
{
    _LsBanner = LsBanner;
    NSMutableArray *imgs = [NSMutableArray array];
    [LsBanner enumerateObjectsUsingBlock:^(MQLaBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,obj.ImgUrl];
        [imgs addObject:imgUrl];
    }];
    _sdView.imageURLStringsGroup = imgs;
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    MQLaBannerModel *model = _LsBanner[index];
    _bannerClick(model);
}

@end
