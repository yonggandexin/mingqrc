//
//  MQPubHeaderView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPubHeaderView.h"
#import "MQHeader.h"
@interface MQPubHeaderView()
<
TZImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnCentY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnCentX;


- (IBAction)photClicked:(id)sender;
@end
@implementation MQPubHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];

    _photoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_backImage setImageToBlur:[UIImage imageNamed:@"beijing"] blurRadius:20 completionBlock:nil];
    
    
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    if (imgUrl) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",imgTestIP,imgUrl];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        [_photoImgV sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [MBProgressHUD hideHUDForView:self.vc.view animated:YES];
            if (image) {
                [_backImage setImageToBlur:image blurRadius:30 completionBlock:^{
                    if (_IT_Block) {
                        //营业执照识别
                        NSString *imgStr = [image imageOfBase64];
                        _IT_Block(imgStr);
                    }
                }];
            }else{
                [MBProgressHUD showAutoMessage:@"当前网络不好"];
            }
        }];
    }
}

/**
 打开相机、相册
 */
- (IBAction)photClicked:(id)sender
{
    //cropRectPortrait  cropRectLandscape
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];

    imagePickerVc.sortAscendingByModificationDate = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self uploadImage:photos[0]];
        
    }];
    [_vc presentViewController:imagePickerVc animated:YES completion:nil];
}

/**
 上传照片
 */
- (void)uploadImage:(UIImage *)image
{
    [MBProgressHUD showMessage:@"上传中..." ToView:self.vc.view];
    [[NetworkHelper shareInstance] uploadImage:image success:^(id res) {
        
        self.imgUrl = res;
   
    } failure:^(NSString *error) {
//        [MBProgressHUD showAutoMessage:@"图片上传失败"];
        [MBProgressHUD hideHUDForView:self.vc.view animated:YES];
    }];
}

@end


@implementation MQHeaderBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = self.imageView.height = 60;
    self.imageView.y = 0;
    self.imageView.x = (self.width-self.imageView.width)*0.5;
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.height = self.height-self.imageView.height;
    
}
@end
