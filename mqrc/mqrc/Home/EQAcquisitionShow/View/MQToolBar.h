//
//  MQToolBar.h
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQToolBar : UIView
@property (nonatomic, strong) NSDictionary *ContactDic;

@end
@interface BarButton : UIButton
@property (nonatomic, assign) CGFloat WH;
@end

@interface HeaderBtn : BarButton

@end
