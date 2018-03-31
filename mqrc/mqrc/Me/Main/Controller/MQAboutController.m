//
//  MQAboutController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/15.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQAboutController.h"
#import "MQWebViewController.h"
@interface MQAboutController ()
@property (weak, nonatomic) IBOutlet UILabel *versionL;
- (IBAction)PrivacyBtnClicked:(id)sender;

@end

@implementation MQAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    NSString *localVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionL.text = [NSString stringWithFormat:@"V%@", localVer ];
}

- (IBAction)PrivacyBtnClicked:(id)sender {
    MQWebViewController *webVC = [MQWebViewController new];
    webVC.Url = @"http://mp.zhanqitx.com/Reading80B2FA680507B6F2222A7C188B1FEA21";
    [self.navigationController pushViewController:webVC animated:YES];
}
@end
