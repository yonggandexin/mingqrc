//
//  MQResaultView.h
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MQResaultViewDelegate<NSObject>

- (void)goCheckAlreadyData;

@end
@class MQBaseSureBtn;
@interface MQResaultView : UIView
@property (nonatomic, strong) MQBaseSureBtn *btn;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, weak) id<MQResaultViewDelegate> delegate;

+(instancetype)show:(NSArray *)models;

@end
