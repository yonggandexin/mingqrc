//
//  UIImage+MQBase64.m
//  mqrc
//
//  Created by 朱波 on 2018/2/7.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "UIImage+MQBase64.h"
#import <UIKit/UIKit.h>
@implementation UIImage (MQBase64)
- (NSString *)imageOfBase64{
    /*使用Base64字符串传图片*/
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    float size = imageData.length/1024.0/1024.0;
    if (size>=1) {
        imageData = UIImageJPEGRepresentation(self, 0.3);
    }else{
        imageData = UIImageJPEGRepresentation(self, 0.5);
    }
    NSString *pictureDataString=  [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return pictureDataString;
}
@end
