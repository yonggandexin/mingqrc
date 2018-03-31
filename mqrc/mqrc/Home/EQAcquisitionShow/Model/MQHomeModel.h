//
//  MQHomeModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MQLaBannerModel,MQGuessLikeModel;
@interface MQHomeModel : NSObject
//轮播图
@property (nonatomic, strong) NSArray <MQLaBannerModel *>*LsBanner;
//猜你喜欢
@property (nonatomic, strong) NSArray <MQGuessLikeModel *>*LsGuessLike;
//公告
@property (nonatomic, strong) NSArray *LsNews;


@end
