//
//  MQFrameBaseCell.h
//  mqrc
//
//  Created by 朱波 on 2017/12/20.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQFrameBaseCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backImgV;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *arrowV;

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) UILabel *starL;

@property (nonatomic, copy) NSString *placeStr;
- (void)cellIsFirst:(BOOL)isFirst;
@end
