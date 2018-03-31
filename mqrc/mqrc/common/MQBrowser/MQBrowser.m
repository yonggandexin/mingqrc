//
//  MQBrowser.m
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQBrowser.h"
#import "MQHeader.h"
#import "MQPhotoCell.h"
@interface MQBrowser()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong) MQBrowser *backView;
@property (nonatomic, strong) NSArray *imagUrls;
@end

@implementation MQBrowser

+ (void)show:(NSArray *)imageUrls
{
    
    MQBrowser *backView = [[MQBrowser alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.imagUrls = imageUrls;
    backView.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-40, 25, 30, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [btn addTarget:backView action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
}

- (void)btnClicked
{
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addCollectionView];
        
    }
    return self;
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [self addSubview:collectionV];
    
    [collectionV registerNib:[UINib nibWithNibName:@"MQPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"photo"];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
