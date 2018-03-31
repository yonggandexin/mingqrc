//
//  MQFullBottomView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFullBottomView.h"
#import "MQHeader.h"
#import <ShareSDK/ShareSDK.h>

@interface MQFullBottomView()
@property (nonatomic, strong) BottomBtn *collectBtn;
@end
@implementation MQFullBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initChildView];
        
    }
    return self;
}

- (void)initChildView
{
    BottomBtn *collectBtn = [BottomBtn buttonWithType:UIButtonTypeCustom];
    collectBtn.backgroundColor = [UIColor whiteColor];
    collectBtn.titleLabel.font = font(11);
    collectBtn.frame = CGRectMake(0, 0, self.height+10, self.height);
    [collectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:collectBtn];
    _collectBtn = collectBtn;
    
    
    BottomBtn *shareBtn = [BottomBtn buttonWithType:UIButtonTypeCustom];
    shareBtn.backgroundColor = [UIColor whiteColor];
    shareBtn.titleLabel.font = font(11);
    shareBtn.frame = CGRectMake(CGRectGetMaxX(collectBtn.frame), 0, collectBtn.width, self.height);
    [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"shareRe"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    
    UIButton *resumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resumeBtn.frame = CGRectMake(CGRectGetMaxX(shareBtn.frame), 0, self.width-CGRectGetMaxX(shareBtn.frame), self.height);
    [resumeBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    resumeBtn.titleLabel.textColor = [UIColor whiteColor];
    [resumeBtn setBackgroundImage:[UIImage imageNamed:@"KeyBackground"] forState:UIControlStateNormal];
     [resumeBtn setBackgroundImage:[UIImage imageNamed:@"KeyBackground1"] forState:UIControlStateDisabled];
    [self addSubview:resumeBtn];
    _resumeBtn = resumeBtn;
}


- (void)btnClicked:(UIButton *)btn
{
    if (![MQLoginTool shareInstance].model) {
        [MQLoginTool presentLogin];
        return;
    }
     btn.enabled = NO;
    if (_IsCollect == NO) {
        NSDictionary *pram = @{
                               @"ID":_ID,
                               @"ItemName":@(_itemStyle)
                               };
        [MBProgressHUD showMessage:@"收藏中..." ToView:MQWindow];
        [[NetworkHelper shareInstance]postHttpToServerWithURL:API_AddCollection withParameters:pram success:^(id res) {
            [MBProgressHUD hideHUDForView:MQWindow animated:YES];
            [MBProgressHUD showAutoMessage:@"收藏成功"];
            [btn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
            btn.enabled = YES;
            _IsCollect = YES;
        } failure:^(id error) {
            [MBProgressHUD hideHUDForView:MQWindow animated:YES];
            btn.enabled = YES;
        }];
    }else{
        
        [MBProgressHUD showMessage:@"取消中..." ToView:MQWindow];
        NSDictionary *pram = @{
                               @"ID":_ID,
                               @"ItemName":@(_itemStyle)
                               };
        [[NetworkHelper shareInstance]postHttpToServerWithURL:API_DeleteCollection withParameters:pram success:^(id res) {
            [MBProgressHUD hideHUDForView:MQWindow animated:YES];
            _IsCollect = NO;
            [MBProgressHUD showAutoMessage:@"取消收藏完成"];
            [btn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
            btn.enabled = YES;
        } failure:^(id error) {
            [MBProgressHUD hideHUDForView:MQWindow animated:YES];
            btn.enabled = YES;
        }];
    }
    
    
}

//打电话或投简历
- (void)rightBtnClicked:(UIButton *)btn
{
    if (_toDoBlock) {
       _toDoBlock();
    }
}
//分享
- (void)shareBtnClicked:(UIButton *)btn
{
    if (_shareBlock) {
         _shareBlock();
    }    
}


- (void)setIsCollect:(BOOL)IsCollect
{
    _IsCollect = IsCollect;
    if (IsCollect) {
         [_collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }else{
         [_collectBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    }
}
@end


@implementation BottomBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = 22;
    self.imageView.height = 22;
    self.imageView.centerX = self.width*0.5;
    self.imageView.y = 3;
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height-CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.y =CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end

