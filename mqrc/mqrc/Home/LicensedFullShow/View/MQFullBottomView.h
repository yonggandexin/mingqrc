//
//  MQFullBottomView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectorDo)(void);
typedef void(^shareToDo) (void);
typedef NS_ENUM(NSUInteger,CollectionItem) {
    SHARE_TRANSFER,
    SHARE_TAKEOVER,
    FULL_JOB_POSITON,
    PART_JOB_POSITON
};
@interface MQFullBottomView : UIView
@property (nonatomic, strong) UIButton *resumeBtn;
@property (nonatomic, copy) selectorDo toDoBlock;

@property (nonatomic, copy) shareToDo shareBlock;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) CollectionItem itemStyle;
@property (nonatomic, assign) BOOL IsCollect;//是否已经收藏

@end

@interface BottomBtn : UIButton


@end
