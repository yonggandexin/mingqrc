//
//  MQBrowserController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/13.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQBrowserController.h"
#import "MQHeader.h"
#import "MQPhotoCell.h"
@interface MQBrowserController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>
{
   int _fold[1];
}
@property (nonatomic, strong) UILabel *lable;
@end

@implementation MQBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-100);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionV.pagingEnabled = YES;
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [self.view addSubview:collectionV];
    
    [collectionV registerNib:[UINib nibWithNibName:@"MQPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"photo"];
    
    [collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    UILabel *lable = [UILabel new];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = font(15);
    lable.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [self.view addSubview:lable];
    _lable = lable;
    [self scrollViewDidScroll:collectionV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MQPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.imgUrl = self.imagUrls[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    _lable.text = [NSString stringWithFormat:@"%zd/%zd",index+1,_imagUrls.count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//       _fold[0]^=1;
//    if (_fold[0] == 1) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.navigationController.navigationBar.y-=64;
//        }];
//    }else{
//        [UIView animateWithDuration:0.5 animations:^{
//            self.navigationController.navigationBar.y+=64;
//        }];
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
