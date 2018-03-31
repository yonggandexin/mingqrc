//
//  MQHandleFooterView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/12.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQHandleFooterView.h"
#import "MQHeader.h"
@interface MQHandleFooterView()
<
TZImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UIImageView *photoV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoH;
- (IBAction)photoBtnClicked:(id)sender;


@end
@implementation MQHandleFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _photoH.constant = DPH(220);
    
}

- (IBAction)photoBtnClicked:(id)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.sortAscendingByModificationDate = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self uploadImage:photos[0]];
    }];
    [_superVC presentViewController:imagePickerVc animated:YES completion:nil];
    
    
}

/**
 上传照片
 */
- (void)uploadImage:(UIImage *)image
{
    [MBProgressHUD showMessage:@"上传中..." ToView:_superVC.view];
    [[NetworkHelper shareInstance] uploadImage:image success:^(id res) {
        
        [MBProgressHUD hideHUDForView:_superVC.view animated:YES];
        _photoV.image = image;
        self.imgUrl = res;
    } failure:^(NSString *error) {
        [MBProgressHUD showAutoMessage:@"图片上传失败"];
        [MBProgressHUD hideHUDForView:_superVC.view animated:YES];
    }];
}
@end
