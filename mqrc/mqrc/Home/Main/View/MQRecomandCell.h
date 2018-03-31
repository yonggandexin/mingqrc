//
//  MQRecomandCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQLaBannerModel;
@interface MQRecomandCell : UITableViewCell
@property (nonatomic, strong) NSArray <MQLaBannerModel *>*MiddleAdvert;
@property (nonatomic, strong) UIViewController *superVC;
@end
