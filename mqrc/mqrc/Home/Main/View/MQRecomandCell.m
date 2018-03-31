//
//  MQRecomandCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRecomandCell.h"
#import "MQLaBannerModel.h"
#import "MQHeader.h"
#import "MQWebViewController.h"
@interface MQRecomandCell()
- (IBAction)rightBtnClicked:(id)sender;
- (IBAction)leftBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;

@end
@implementation MQRecomandCell

- (void)setMiddleAdvert:(NSArray<MQLaBannerModel *> *)MiddleAdvert
{
    _MiddleAdvert = MiddleAdvert;
    
    MQLaBannerModel *leftM = MiddleAdvert[0];
    _leftTitle.text = leftM.Title;
    NSString *leftUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,leftM.ImgUrl];
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:leftUrl] placeholderImage:[UIImage imageNamed:@"placeholder100"]];
    
    MQLaBannerModel *rightM = MiddleAdvert[1];
    _rightTitle.text = rightM.Title;
    NSString *rightUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,rightM.ImgUrl];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:rightUrl] placeholderImage:[UIImage imageNamed:@"placeholder100"]];
    
}
- (IBAction)rightBtnClicked:(id)sender {
    
    MQLaBannerModel *rightM = _MiddleAdvert[1];
    MQWebViewController *webVC = [MQWebViewController new];
    webVC.Url = rightM.Url;
    [self.superVC.navigationController pushViewController:webVC animated:YES];
    
}

- (IBAction)leftBtnClicked:(id)sender {
    
    MQLaBannerModel *leftM = _MiddleAdvert[0];
    MQWebViewController *webVC = [MQWebViewController new];
    webVC.Url = leftM.Url;
    [self.superVC.navigationController pushViewController:webVC animated:YES];
    
}
@end
