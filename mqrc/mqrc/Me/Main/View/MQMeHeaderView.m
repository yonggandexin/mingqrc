//
//  MQMeHeaderView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/6.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQMeHeaderView.h"
#import "MQMyCollectController.h"
#import "ZBWaveView.h"
#import "MQHeader.h"
@interface MQMeHeaderView()
<
TZImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *nameL;
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
    
    _waveView.waveSpeed = 2.0f;
    _waveView.waveAmplitude = 10.0f;
    _waveView.waveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [_waveView wave];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked:)];
    [_headImgV addGestureRecognizer:tap];
    
    [MQNotificationCent addObserver:self selector:@selector(regsinLoginToDo) name:regsinLogin object:nil];
    [MQNotificationCent addObserver:self selector:@selector(starLoginToDo) name:starLogin object:nil];
}

- (void)regsinLoginToDo
{
    _nameL.text = @"";
    _headImgV.image = [UIImage imageNamed:@"placeholder100"];
}

- (void)starLoginToDo
{
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    _nameL.text = model.MOBILE;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgTestIP,model.AVATAR]];
     [_headImgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder100"]];
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    if (!model) {
        [MQLoginTool presentLogin];
        return;
    }
    [self editPersonalData];
}
- (void)setModel:(MQLoginModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgTestIP,model.AVATAR]];
    [_headImgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder100"]];
    
    _nameL.text = model.MOBILE;
}

- (void)editPersonalData
{
    //cropRectPortrait  cropRectLandscape
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
    [_superVC showHudWithTitle:@"上传中..."];
    /*使用Base64字符串传图片*/
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    float size = imageData.length/1024.0/1024.0;
    if (size>=1) {
        imageData = UIImageJPEGRepresentation(image, 0.3);
    }else{
        imageData = UIImageJPEGRepresentation(image, 0.5);
    }
    NSString *pictureDataString=  [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *pram = @{
                           @"filedata":pictureDataString
                           };
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_uploadAvatar withParameters:pram success:^(id res) {
        _headImgV.image = image;
        [_superVC hideHudVCview];
    } failure:^(id error) {
        [_superVC hideHudVCview];
    }];

}

- (IBAction)minePublishClicked:(id)sender
{
    
}


- (IBAction)mineCollection:(id)sender
{
    [_superVC.navigationController pushViewController:[MQMyCollectController new] animated:YES];
}
@end
