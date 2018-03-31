//
//  MQSectionView.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,recommonStyle) {
    transferStyle,
    jobWantedPartStyle
};
typedef void(^btnBlock) (recommonStyle);
@interface MQSectionView :UIView

@property (nonatomic, copy) btnBlock selectedBlock;

@end
