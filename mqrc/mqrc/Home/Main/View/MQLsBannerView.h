//
//  MQLsBannerView.h
//  mqrc
//
//  Created by 朱波 on 2018/1/25.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQLaBannerModel;
typedef void(^bannerBlock) (MQLaBannerModel *);
@interface MQLsBannerView : UIView
//轮播图
@property (nonatomic, strong) NSArray <MQLaBannerModel *>*LsBanner;

@property (nonatomic, copy) bannerBlock bannerClick;
@end
