//
//  MQHandleFooterView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQHandleFooterView : UIView
/**
 提交审核按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
/**
父控制器
 */
@property (nonatomic, strong) UIViewController *superVC;

/**
 图片上传成功后的URL
 */
@property (nonatomic, copy) NSString *imgUrl;
@end
