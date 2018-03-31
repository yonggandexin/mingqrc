//
//  MQVersionView.m
//  mqrc
//
//  Created by 朱波 on 2018/1/24.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQVersionView.h"
#import "MQHeader.h"
@interface MQVersionView()
- (IBAction)refuseBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet UILabel *verLable;
- (IBAction)goToUpdate:(id)sender;
@end

@implementation MQVersionView
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSString *desStr = @"1.修复已知bug\n2.优化发布模块编辑功能";
    _desL.text = desStr;
}
- (IBAction)refuseBtnClicked:(id)sender
{
    [self hideVersionView];
}
- (IBAction)goToUpdate:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrlStr] options:@{} completionHandler:^(BOOL success) {
        [self hideVersionView];
    }];
}

- (void)setVersionSer:(NSString *)versionSer
{
    _versionSer = versionSer;
    _verLable.text = versionSer;
}

- (void)hideVersionView
{
    UIView *supV = self.superview;
    [supV removeFromSuperview];
}

@end
