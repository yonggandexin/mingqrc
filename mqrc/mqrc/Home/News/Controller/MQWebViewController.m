//
//  MQWebViewController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/17.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQWebViewController.h"
#import "MQHeader.h"
@interface MQWebViewController ()
<
UIWebViewDelegate
>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, retain) UIWebView   *webView;
@property (assign, nonatomic) NSUInteger loadCount;
@end

@implementation MQWebViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initWebView];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    _progressView.tintColor = [UIColor orangeColor];
    _progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:_progressView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)initWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH)];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_Url]]];
    [self.view addSubview:_webView];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadCount ++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadCount --;
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadCount --;
}

- (void)setLoadCount:(NSUInteger)loadCount {
    
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}
@end
