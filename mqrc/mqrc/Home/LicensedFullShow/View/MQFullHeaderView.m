//
//  MQFullHeaderView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/23.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQFullHeaderView.h"
#import "MQFullShowCell.h"
#import "MQFullDesModel.h"
#import "MQHeader.h"
#import "MQTagList.h"
#import "MQPartDesModel.h"
#import "TXScrollLabelView.h"
#define cellH 22
#define baseH 410
@interface MQFullHeaderView()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fuliH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cerH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MQTagList *listV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *scanL;
@property (weak, nonatomic) IBOutlet FullBtn *regionL;
@property (weak, nonatomic) IBOutlet FullBtn *experenceL;
@property (weak, nonatomic) IBOutlet FullBtn *educationL;
@property (weak, nonatomic) IBOutlet FullBtn *numberL;
@property (weak, nonatomic) IBOutlet UIView *scrollCerView;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (nonatomic, strong) NSArray *Qualifications;
@end
@implementation MQFullHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerCellName:[UITableViewCell class]];
}

- (void)setModel:(MQFullDesModel *)model
{
    _model = model;
    [self addComQualification:model.CompanyQualifications];
    _Qualifications = model.Qualifications;
    [_tableView reloadData];
    _titleL.text = model.Title;
    _salaryL.text = [NSString stringWithFormat:@"【%@】",model.JobSalary];
    _timeL.text = [NSString stringWithFormat:@"更新:%@",[self showTime:model.AddTime]];
    _scanL.text = [NSString stringWithFormat:@"浏览(%zd)",model.Clicks];
    
    [_regionL setTitle:model.WorkAddress forState:UIControlStateNormal];
    [_experenceL setTitle:model.WorkExp forState:UIControlStateNormal];
    [_experenceL setImage:[UIImage imageNamed:@"Education"] forState:UIControlStateNormal];
    [_educationL setTitle:model.RequireEducation forState:UIControlStateNormal];
    [_numberL setTitle:[NSString stringWithFormat:@"%zd人",model.RecruitmentNumber] forState:UIControlStateNormal];
    [_listV addTags:model.JobWelfares];
    _contentL.attributedText = [model.Content creatAttFont:font(13)];
    
    _cerH.constant = model.Qualifications.count*cellH;
    [self layoutIfNeeded];
    CGSize desSize =[model.Content strSizeWithFont:font(13)];
    
    self.height = baseH+desSize.height+_cerH.constant-cellH;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    [tableView reloadData];
    
}

//跑马灯显示企业所具备资质
- (void)addComQualification:(NSArray *)quas
{
    if (quas.count>0) {
        NSMutableArray *Titles = [NSMutableArray array];
        [quas enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [Titles addObject:obj];
        }];
        NSString *titleStr = [Titles componentsJoinedByString:@"   "];
        TXScrollLabelView *scrollLabelView = [TXScrollLabelView scrollWithTitle:titleStr type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut];
//        scrollLabelView.scrollLabelViewDelegate = self;
        scrollLabelView.frame = _scrollCerView.bounds;
        scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        scrollLabelView.scrollSpace = 10;
        scrollLabelView.font = [UIFont systemFontOfSize:14];
        scrollLabelView.textAlignment = NSTextAlignmentCenter;
        scrollLabelView.backgroundColor = [UIColor whiteColor];
        scrollLabelView.scrollTitleColor = [UIColor grayColor];
        [_scrollCerView addSubview:scrollLabelView];
        [scrollLabelView beginScrolling];
    }    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Qualifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    NSString *str = _Qualifications[indexPath.row];
    if (str.length>0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row+1,_Qualifications[indexPath.row]];
    }
    
    return cell;
}

- (void)setPartModel:(MQPartDesModel *)partModel
{
     _partModel = partModel;
    [self addComQualification:partModel.CompanyQualifications];
     _Qualifications = partModel.Qualifications;
    [_tableView reloadData];
    _titleL.text = partModel.Title;
    _timeL.text = [NSString stringWithFormat:@"更新:%@",[self showTime:partModel.AddTime]];
    _scanL.text = [NSString stringWithFormat:@"浏览(%zd)",partModel.Clicks];
    _salaryL.text = [NSString stringWithFormat:@"【%@】",partModel.JobSalary];
    [_regionL setTitle:partModel.WorkAddress forState:UIControlStateNormal];
    [_educationL setTitle:partModel.RequireEducation forState:UIControlStateNormal];
    [_numberL setTitle:[NSString stringWithFormat:@"%zd人",partModel.RecruitmentNumber] forState:UIControlStateNormal];
    
    _contentL.attributedText = [partModel.Content creatAttFont:font(13)];
    _fuliH.constant = 0;
    _cerH.constant =_Qualifications.count*cellH;
    [self layoutIfNeeded];
    CGSize desSize =[partModel.Content strSizeWithFont:font(13)];
    
    self.height = baseH-35+desSize.height+_cerH.constant-cellH;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    [tableView reloadData];
}
@end
