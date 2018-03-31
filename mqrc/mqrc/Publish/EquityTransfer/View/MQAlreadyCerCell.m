//
//  MQAlreadyCerCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQAlreadyCerCell.h"
#import "MQSubCerModel.h"
#import "MQHeader.h"
#import "MQAddCerController.h"
@interface MQAlreadyCerCell()<TZImagePickerControllerDelegate>
- (IBAction)disBtnClicked:(id)sender;
- (IBAction)photoClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *disBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end
@implementation MQAlreadyCerCell

-(void)setModel:(MQSubCerModel *)model
{
    _model = model;
    _titleL.text = model.Name;
//    _imageV.image = model.img;
    _disBtn.hidden = _model.ImgUrl.length>0?NO:YES;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",imgTestIP,model.ImgUrl];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"placeholder100"]];
}

- (IBAction)disBtnClicked:(id)sender {
    _model.ImgUrl = @"";
    [_vc.tableView reloadData];
}

- (IBAction)photoClicked:(id)sender {
    
    if (_model.ImgUrl.length>0) {
        [MBProgressHUD showAutoMessage:@"最多只能添加一张照片"];
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
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
    [[NetworkHelper shareInstance] uploadImage:image success:^(id res) {
//        _model.img = image;
        _model.ImgUrl = res;
        [_vc.tableView reloadData];
    } failure:^(NSString *error) {
        
    }];
}

@end
