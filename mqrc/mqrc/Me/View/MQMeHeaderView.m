//
//  MQMeHeaderView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQMeHeaderView.h"
#import "MQMyCollectController.h"
@interface MQMeHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;

- (IBAction)minePublishClicked:(id)sender;

- (IBAction)mineCollection:(id)sender;
@end
@implementation MQMeHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _headImgV.layer.cornerRadius = 35;
    _headImgV.layer.borderWidth = 3;
    _headImgV.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImgV.layer.masksToBounds = YES;
}
- (IBAction)minePublishClicked:(id)sender
{
    
    
}


- (IBAction)mineCollection:(id)sender
{
    [_superVC.navigationController pushViewController:[MQMyCollectController new] animated:YES];
    
}
@end
