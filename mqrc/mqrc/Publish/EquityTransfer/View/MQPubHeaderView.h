//
//  MQPubHeaderView.h
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^headerBlock) (NSString *);
@interface MQPubHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (nonatomic, strong) UIViewController *vc;
/**
 营业执照
 */
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) headerBlock IT_Block;

@end

@interface MQHeaderBtn : UIButton


@end
