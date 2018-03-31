//
//  MQMyCollectController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/8.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQMyCollectController.h"
#import "MQMyTakeoverController.h"
#import "MQMyTransferController.h"
#import "MQFullJobController.h"
#import "MQPartJobController.h"
#import "MQHeader.h"
@interface MQMyCollectController ()
<
UIScrollViewDelegate
>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, weak) UIButton *selectedTitleButton;

@end

@implementation MQMyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = baseColor;
    self.navigationItem.title = @"我的收藏";
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
   
    [self titleBar];
    
    // 默认添加子控制器的view
    [self addChildVcView];
    
}
- (void)setupChildViewControllers
{
    MQMyTakeoverController *Takeover = [MQMyTakeoverController new];
//    Takeover.Type = ZBTopicTypeVideo;
    [self addChildViewController:Takeover];
    
    MQMyTransferController *transfer = [MQMyTransferController new];
//    Voice.Type = ZBTopicTypeVoice;
    [self addChildViewController:transfer];
    
    MQFullJobController *fullJob = [MQFullJobController new];
//    Picture.Type = ZBTopicTypePicture;
    [self addChildViewController:fullJob];
    
    MQPartJobController *partJob = [MQPartJobController new];
//    Word.Type = ZBTopicTypeWord;
    [self addChildViewController:partJob];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 添加所有子控制器的view到scrollView中
    NSUInteger count = self.childViewControllers.count;
    
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
    
}

- (void)titleBar
{
    
    UIView *titleView = [UIView new];
    titleView.x = 0;
    titleView.y = 0;
    titleView.width = SCREEN_WIDTH;
    titleView.height = 35;
    
    titleView.backgroundColor = [UIColor whiteColor];
    _titleView = titleView;
    [self.view addSubview:titleView];
    // 添加标题
    NSUInteger count = self.titles.count;
    CGFloat titleButtonW = titleView.width / count;
    CGFloat titleButtonH = titleView.height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:mainColor forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        titleButton.tag = i;
        // 设置数据
        [titleButton setTitle:self.titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
    }
    
    UIButton *firstTitleButton = titleView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    [firstTitleButton.titleLabel sizeToFit];
    [self titleClick:firstTitleButton];
    
}

-(void)titleClick:(UIButton *)titleButton
{
    
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = titleButton.titleLabel.width;
        CGPoint center = self.indicatorView.center;
        center.x = titleButton.center.x;
        
        self.indicatorView.center = center;
        
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    [self addChildVcView];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *titleButton = self.titleView.subviews[index];
    [self titleClick:titleButton];
    
    [self addChildVcView];
    
}
-(void)addChildVcView
{
    
    NSUInteger index = _scrollView.contentOffset.x / _scrollView.width;
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.x = index*_scrollView.width;
    childVC.view.y = 0;
    childVC.view.width = _scrollView.width;
    childVC.view.height = _scrollView.height;
    [_scrollView addSubview:childVC.view];
}

- (NSArray *)titles
{
    return @[@"股权转让", @"股权收购", @"持证全职", @"持证兼职"];
}
@end
