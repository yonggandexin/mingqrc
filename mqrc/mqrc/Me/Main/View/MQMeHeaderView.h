//
//  MQMeHeaderView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBWaveView.h"
@class MQLoginModel;
@protocol personalDelegate <NSObject>

- (void)editPersonalData;

@end

@interface MQMeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet ZBWaveView *waveView;
@property (nonatomic, strong) UIViewController *superVC;
@property (nonatomic, weak) id<personalDelegate> delegate;
@property (nonatomic, strong) MQLoginModel *model;
@end
