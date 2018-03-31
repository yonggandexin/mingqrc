//
//  MQToolBar.m
//  mqrc
//
//  Created by 朱波 on 2017/12/1.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQToolBar.h"
#import "MQHeader.h"
#define rotation 0.4
@interface MQToolBar()

- (IBAction)CollectionClicked:(id)sender;
@property (weak, nonatomic) IBOutlet HeaderBtn *ContactBtn;
-(IBAction)tellBtnClicked:(id)sender;
@end
@implementation MQToolBar

- (void)setContactDic:(NSDictionary *)ContactDic
{
    _ContactDic = ContactDic;
    [_ContactBtn setTitle:[ContactDic objectForKey:@"Name"] forState:UIControlStateNormal];
}

//打电话
-(IBAction)tellBtnClicked:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_ContactDic objectForKey:@"Phone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    });
}
//收藏
- (IBAction)CollectionClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
@end

@implementation BarButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
    self.imageView.width = self.WH;
    self.imageView.height = self.WH;
    self.imageView.x = 20;
    self.imageView.y = (self.height-self.imageView.height)*0.5;
    
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame)+10;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width-self.titleLabel.x;
    self.titleLabel.height = self.height;
    
}

- (CGFloat)WH
{
    return 23;
}

@end


@implementation HeaderBtn

- (CGFloat)WH
{
    return 30;
}

@end
