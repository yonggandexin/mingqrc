//
//  MQHomeCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/4.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQHomeCell.h"
@interface MQHomeCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UIImageView *centerImg;

@end
@implementation MQHomeCell

- (void)setImgName:(NSString *)imgName
{
    _imgName = imgName;
    _backImageV.image = [UIImage imageNamed:imgName];
}

- (void)setCentImages:(NSString *)centImages
{
    _centImages = centImages;
    _centerImg.image = [UIImage imageNamed:centImages];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleL.text = title;
}
@end
