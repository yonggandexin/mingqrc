//
//  MQRecruitTypeController.m
//  mqrc
//
//  Created by 朱波 on 2017/12/15.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQRecruitTypeController.h"
#import "MQHeader.h"
#import "MQPubLicenseFullController.h"
#import "MQLicensePartController.h"
@interface MQRecruitTypeController ()
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MQRecruitTypeController
- (NSArray *)imageNames
{
    return @[@"FullTime",@"PartTimeJob",@"holdacertificate",@"Licensedpart-timejob"];
}

- (NSArray *)titles
{
    return @[@"普通全职",@"普通兼职",@"持证全职",@"持证兼职"];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"招聘类型";
    [self addTypeButton];

}


- (void)addTypeButton
{
    CGFloat board = 30;
    
    CGFloat W = 170;
    CGFloat H = 100;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000+i;
        btn.titleLabel.font = font(15);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.width = W;
        btn.height = H;
        btn.x = (SCREEN_WIDTH-btn.width)*0.5;
        btn.y = DPH(110)+i*(btn.height+board)-nav_barH;
        [self.view addSubview:btn];
        
        UILabel *lable = [UILabel new];
        lable.x = btn.x;
        lable.y = btn.y-board;
        lable.width = btn.width;
        lable.height = board;
        lable.text = self.titles[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        lable.textColor = [UIColor grayColor];
        [self.view addSubview:lable];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y, 0, 0)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y, btn.width, btn.height)];
        anim.springSpeed = 5;
        anim.springBounciness = 20;
        anim.beginTime = CACurrentMediaTime()+0.3*i;
        [btn pop_addAnimation:anim forKey:nil];
        
        
    }
}

- (void)btnClicked:(UIButton *)btn
{
    NSInteger index = btn.tag-1000;
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[MQPubLicenseFullController new] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[MQLicensePartController new] animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
