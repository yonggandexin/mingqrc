//
//  MQLaBannerModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLaBannerModel : NSObject
//ID = DE1CC39F05C9475B947CD018F0C6B1D6;
//ImgUrl = "/upload/manager/image/201801/12345678911.png";
//Url = "";
@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Title;
@end
