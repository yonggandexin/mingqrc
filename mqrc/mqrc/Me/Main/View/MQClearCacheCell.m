//
//  MQClearCacheCell.m
//  mqrc
//
//  Created by 朱波 on 2018/1/15.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQClearCacheCell.h"
#import "SDImageCache.h"
#import "NSString+ZBFillSize.h"
#import "MQHeader.h"
@implementation MQClearCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleL = [UILabel new];
        self.titleL.textAlignment = NSTextAlignmentLeft;
        self.titleL.textColor = [UIColor grayColor];
        self.titleL.font = font(15);
        self.titleL.x = 10;
        self.titleL.y = 0;
        self.titleL.height = self.contentView.height;
        self.titleL.width = 180;
        [self.contentView addSubview:self.titleL];
        
        // 设置cell右边的指示器(用来说明正在处理一些事情)
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [loadingView startAnimating];
//        self.accessoryView = loadingView;
        // 设置cell默认的文字(如果设置文字之前userInteractionEnabled=NO, 那么文字会自动变成浅灰色)
        self.titleL.text = @"清除缓存(正在计算缓存大小...)";
        
        // 禁止点击
        self.userInteractionEnabled = NO;
        
        // 在子线程计算缓存大小
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            
            unsigned long long size = [@"default" fileSizeForFile];
            size += [SDImageCache sharedImageCache].getSize;
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
            
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                self.titleL.text = text;
                // 清空右边的指示器
                self.accessoryView = nil;
                // 显示右边的箭头
//                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                // 添加手势监听器
                [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
                
                // 恢复点击事件
                self.userInteractionEnabled = YES;
            });
            
        });
        
        
    }
    
    return self;
}

-(void)clearCache
{
    // 弹出指示器
    [MBProgressHUD showMessage:@"正在清除缓存..." ToView:[UIApplication sharedApplication].keyWindow];
    
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:[@"default" getCachesFileParth] error:nil];
            [mgr createDirectoryAtPath:[@"default" getCachesFileParth] withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                
                // 设置文字
                self.titleL.text = @"清除缓存(0B)";
            });
        });
    }];
    
    
}
@end
