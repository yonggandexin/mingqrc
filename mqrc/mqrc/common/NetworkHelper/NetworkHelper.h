//
//  NetworkHelper.h
//  mqrc
//
//  Created by VA on 2017/4/22.
//  Copyright © 2017年 kingman. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface NetworkHelper : NSObject


+ (instancetype)shareInstance;

- (NSURLSessionDataTask *)postHttpToServerWithURL:(NSString *)urlString
                 withParameters:(id)aParameter
                        success:(void (^) (id res))result
                        failure:(void (^) (id error))failure;

- (void)uploadImage:(UIImage *)image
             success:(void (^) (id res))result
             failure:(void (^) (NSString *error))failure;


@property (nonatomic, assign) BOOL isDimo;

- (void)cancelRequest;
@end
