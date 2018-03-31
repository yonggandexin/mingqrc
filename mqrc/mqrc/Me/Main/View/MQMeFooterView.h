//
//  MQMeFooterView.h
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MQFootDelegate <NSObject>
- (void)clickWithIndex:(NSInteger)index;
@end
@interface MQMeFooterView : UIView

@property (nonatomic, weak) id<MQFootDelegate>delegate;
@end

@interface mqMeFooterBtn : UIButton

@end
