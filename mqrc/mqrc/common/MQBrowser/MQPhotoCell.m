//
//  MQPhotoCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/11.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPhotoCell.h"
#import "MQHeader.h"
@interface MQPhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end
@implementation MQPhotoCell

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@""]];
}
@end
