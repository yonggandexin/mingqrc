//
//  MQPublishController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQPublishController.h"
#import "MQHeader.h"
#import "MQLoginController.h"
#import "MQLoginModel.h"
#import "MQEqAcquisController.h"
#import "MQEnterCerController.h"
#import "MQCheckStateModel.h"
#import "MQRecruitCerController.h"
#import "MQEnterCerListController.h"
#import "MQJobWantedController.h"
#import "MQPubLicenseFullController.h"
#import "MQLicensePartController.h"
#import "MQPreviewResumeVC.h"
@interface MQPublishController ()
@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *weakL;
@property (weak, nonatomic) IBOutlet UILabel *yearL;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imgs;
- (IBAction)dismissClicked:(id)sender;

@end

@implementation MQPublishController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self currentDate];

    [self addTypeButton];
}

- (void)addTypeButton
{
    NSInteger row = 3;
    CGFloat margin = 50;
    CGFloat board = 35;
    
    CGFloat W = (SCREEN_WIDTH-2*margin-(row-1)*board)/row;
    CGFloat H = W;
    
    for (int i = 0; i<self.imgs.count; i++) {
        MQBaseButton *btn = [MQBaseButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000+i;
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.imgs[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = font(11);
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.width = W;
        btn.height = H;
        btn.x = margin+(i%row)*board+(i%row)*W;
        btn.y = (i/row)*(H +10)+SCREEN_HEIGHT-DPH(270)+SCREEN_HEIGHT;
        btn.imageView.layer.cornerRadius = btn.height*0.7*0.5;
        btn.imageView.layer.borderWidth = 2;
        btn.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.imageView.layer.masksToBounds = YES;
        [self.view addSubview:btn];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y, btn.width, btn.height)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y-SCREEN_HEIGHT, btn.width, btn.height)];
        anim.springSpeed = 10;
        anim.springBounciness = 7;
        anim.beginTime = CACurrentMediaTime()+0.1*i;
        [btn pop_addAnimation:anim forKey:nil];
        
    }
}

-(NSArray *)imgs
{
    return @[@"Buy",@"TransferThePossessionOf",@"Full-time",@"Part-timeJob",@"PersonalJobHunting"];
}

-(NSArray *)titles
{
    return @[@"股权收购",@"股权转让",@"持证全职",@"持证兼职",@"个人求职"];
}
- (void)currentDate {
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    NSString *day = [NSString stringWithFormat:@"%ld",currentDay];
    NSString *month = [NSString stringWithFormat:@"%ld",currentMonth];
    NSString *week = [self weekdayStringFromDate:date];
    if (currentMonth < 10) {
        month = [NSString stringWithFormat:@"0%@",month];
    }
    if (currentDay < 10) {
        day = [NSString stringWithFormat:@"0%@",day];
    }
    _yearL.text = [NSString stringWithFormat:@"%@/%ld",month,currentYear];
    _dayL.text = day;
    _weakL.text = week;
    
}

- (NSString *)weekdayStringFromDate:(NSDate *)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (void)btnClicked:(UIButton *)btn
{
    MQLoginModel *model = [MQLoginTool shareInstance].model;
    if (!model) {
         [MQLoginTool presentLogin];
        return;
    }
    NSInteger tag = btn.tag-1000;
    switch (tag) {
        case 0:
        {
            //股权收购
            MQEqAcquisController *acqVC = [MQEqAcquisController new];
            [self.navigationController pushViewController:acqVC animated:YES];
        }
            break;
        case 1:
        {
                //去认证企业
            [self.navigationController pushViewController:[MQEnterCerListController new] animated:YES];

        }
            break;
        case 2:
        {
            if (model.IS_USER_AUTH == YES) {
                //已经认证成功
                [self.navigationController pushViewController:[MQPubLicenseFullController new] animated:YES];
            }else{
                 [self.navigationController pushViewController:[MQRecruitCerController new] animated:YES];
            }

        }
            break;
        case 3:
        {
            if (model.IS_USER_AUTH == YES) {
                //已经认证成功
                [self.navigationController pushViewController:[MQLicensePartController new] animated:YES];
            }else{
                //还未认证成功
                [self.navigationController pushViewController:[MQRecruitCerController new] animated:YES];
            }

        }
            break;
        case 4:
        {
            if (model.IsResume == YES) {
                //预览简历
                MQPreviewResumeVC *resumeVC = [MQPreviewResumeVC new];
                resumeVC.isCreatResume = NO;
                [self.navigationController pushViewController:resumeVC animated:YES];
            }else{
                //创建简历
                MQJobWantedController *vc = [MQJobWantedController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        default:
            break;
    }
}


- (IBAction)dismissClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
