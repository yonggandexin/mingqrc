//
//  MQEmpyDataController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEmpyDataController.h"
#import "MQHeader.h"

@interface MQEmpyDataController ()
<
DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource
>

@end

@implementation MQEmpyDataController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:self.imgName];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.desStr;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:14],
                                 NSForegroundColorAttributeName:[UIColor grayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

@end
