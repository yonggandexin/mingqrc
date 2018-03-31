//
//  MQHomeViewController.m
//  mqrc
//
//  Created by 朱波 on 2018/1/4.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQHomeViewController.h"
#import "MQHomeCell.h"
#import "MQAcquisController.h"
#import "MQHeader.h"
#import "MNavigationBar.h"
#import "MQEqHomeController.h"
#import "MQLaBannerModel.h"
#import "MQHomeModel.h"
#import "MQSectionView.h"
#import "MQHomeTypeCell.h"
#import "MQHomeNewCell.h"
#import "MQHomeAdCell.h"
#import "MQHomeSpecilCell.h"
#import "MQHomeServiceCell.h"
#import "MQRecomandCell.h"
#import "MQGuessLikeCell.h"
#import "MQTransferShowController.h"
#import "MQFullShowController.h"
#import "MQPartShowController.h"
#import "MQPreviewResumeVC.h"
#import "MQJobWantedController.h"
#import "MQTrainTypeConyroller.h"
@interface MQHomeViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *centImages;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MQHomeViewController
- (NSArray *)images
{
    return @[@"Stock acquisition background",@"Equity transfer background",@"Full time background",@"Documentary background",@"Talent cooperation background",@"Talent training background"];
}

- (NSArray *)centImages
{
    return @[@"Equity acquisition icons",@"Equity transfer Icon",@"Certified full time icons",@"Licensed part-time icons",@"Talent cooperation Icon",@"Talent training icons"];
}

- (NSArray *)titles
{
    return @[@"股权收购",@"股权转让",@"持证全职",@"持证兼职",@"个人求职",@"人才培训",@"本地服务",@"本地特色"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTestBtn];
    NSString *province = [LocaltionInstance shareInstance].province;
    XLOG(@"%@",province);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)*0.5, (SCREEN_WIDTH-60)*0.5);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_barH) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;

    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"MQHomeCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MQHomeCell class])];

}

- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"切换端口" forState:UIControlStateNormal];
    btn.titleLabel.font = font(11);
    [btn setTitle:@"2112" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btndimo:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = mainColor;
    btn.center = CGPointMake(SCREEN_WIDTH*0.5, 20);
    btn.bounds = CGRectMake(0, 0, 60, 20);
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
}
- (void)btndimo:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [NetworkHelper shareInstance].isDimo = btn.selected;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MQHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MQHomeCell class]) forIndexPath:indexPath];
    cell.imgName = self.images[indexPath.item];
    cell.centImages = self.centImages[indexPath.row];
    cell.title = self.titles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[MQAcquisController new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[MQTransferShowController new] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[MQFullShowController new] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[MQPartShowController new] animated:YES];
        }
            break;
        case 4:
        {
            if (model) {
                if (model.IsResume == YES) {
                    //预览简历
                    MQPreviewResumeVC *resumeVC = [MQPreviewResumeVC new];
                    resumeVC.isCreatResume = NO;
                    [self.navigationController pushViewController:resumeVC animated:YES];
                }else{
                    //创建简历
                    MQJobWantedController *vc = [MQJobWantedController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else{
                [MQLoginTool presentLogin];
            }
        }
            break;
        case 5:{
            if(model){
                [self.navigationController pushViewController:[MQTrainTypeConyroller new] animated:YES];
            }else{
                [MQLoginTool presentLogin];
            }
           
        }
            break;
        default:
            break;
    }
}
@end
