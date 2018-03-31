//
//  MQEqAcqDes.m
//  mqrc
//
//  Created by 朱波 on 2017/11/30.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEqAcqDes.h"
#import "MQAcqDesModel.h"
#import "MQHeader.h"
#import "YZTagList.h"
#define cellH 22
#define baseH 250
@interface MQEqAcqDes()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UILabel *industyL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *refreshL;
@property (weak, nonatomic) IBOutlet UILabel *scanL;
@property (weak, nonatomic) IBOutlet UILabel *tpeL;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet YZTagList *listV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cerH;
@property (weak, nonatomic) IBOutlet UITableView *cerView;

@end
@implementation MQEqAcqDes
- (void)awakeFromNib
{
    [super awakeFromNib];
  
    _cerView.delegate = self;
    _cerView.dataSource = self;
    _cerView.bounces = NO;
    
    [_cerView registerCellName:[UITableViewCell class]];
}
- (void)setModel:(MQAcqDesModel *)model
{
    _model = model;
    _titleL.text = model.Title;
    _refreshL.text = [NSString stringWithFormat:@"更新:%@",[self showTime:model.AddTime]];
    _scanL.text = [NSString stringWithFormat:@"浏览(%zd)",model.Clicks];
    _tpeL.text = [NSString stringWithFormat:@"%@ %@",model.Province,model.City];
    _industyL.text = model.Industry;
    [_listV addTags:model.Excellence];
    _desL.attributedText = [model.Content creatAttFont:font(13)];
    if (model.Qualifications.count>0) {
        _cerH.constant = model.Qualifications.count*cellH;
    }
    [_cerView reloadData];
    [self layoutIfNeeded];
    CGSize titleSize = [model.Title strSizeWithFont:font(15)];
    CGSize desSize =[model.Content strSizeWithFont:font(13)];
    
    self.height = baseH+titleSize.height+desSize.height+_cerH.constant-cellH;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    [tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.Qualifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        NSString *str = _model.Qualifications[indexPath.row];
        if (str) {
            cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row+1,_model.Qualifications[indexPath.row]];
        }
    
    return cell;
}
@end
