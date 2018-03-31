//
//  MQTrDesHeaderView.m
//  mqrc
//
//  Created by 朱波 on 2017/12/2.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQTrDesHeaderView.h"
#import "YZTagList.h"
#import "MQTransDesModel.h"
#import "MQHeader.h"
#import "MQBrowserController.h"
#define cellH 22
#define baseH 450
@interface MQTrDesHeaderView()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate
>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cerH;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *updateL;
@property (weak, nonatomic) IBOutlet UILabel *scanL;
@property (weak, nonatomic) IBOutlet UILabel *industyL;
@property (weak, nonatomic) IBOutlet UILabel *adressL;
@property (weak, nonatomic) IBOutlet YZTagList *listV;

@property (weak, nonatomic) IBOutlet UILabel *registerTimeL;
@property (weak, nonatomic) IBOutlet UILabel *registerPriceL;
@property (weak, nonatomic) IBOutlet UILabel *comTypeL;
@property (weak, nonatomic) IBOutlet UILabel *rangeL;
@property (weak, nonatomic) IBOutlet UILabel *peopleL;

@end
@implementation MQTrDesHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _imgH.constant = SCREEN_WIDTH*0.5;
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [_tabV registerCellName:[UITableViewCell class]];
    _cycleView.delegate = self;
    _cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)setModel:(MQTransDesModel *)model
{
    _model = model;
    
    [self addImgurlsToCycleView];
    
    _titleL.text = model.Title;
    _updateL.text = [NSString stringWithFormat:@"更新:%@",[self showTime:model.AddTime]];
    _scanL.text = [NSString stringWithFormat:@"浏览(%zd)",model.Clicks];
    _industyL.text = model.Industry;
    _adressL.text = [NSString stringWithFormat:@"%@ %@",model.Province,model.City];
    [_listV addTags:model.Excellences];
    
//    NSString *reistrT = [self showTime:model.RegisTime];
    _registerTimeL.attributedText = [self setAttriButiText:[NSString stringWithFormat:@"%@\n注册日期",model.RegisTime]];
    _registerTimeL.textAlignment = NSTextAlignmentCenter;
    _registerPriceL.attributedText = [self setAttriButiText:[NSString stringWithFormat:@"%@万元\n注册资金",model.RegisPrice]];
    _registerPriceL.textAlignment = NSTextAlignmentCenter;
    _comTypeL.attributedText = [self setAttriButiText:[NSString stringWithFormat:@"%@\n企业类型",model.CompanyType]];
    _comTypeL.textAlignment = NSTextAlignmentCenter;
    
    
    _rangeL.text = model.BusinessScope;
    _peopleL.text = model.PersonInfo;
    
    if (model.Qualifications.count>0) {
        _cerH.constant = model.Qualifications.count*cellH;
    }
    [_tabV reloadData];
    [self layoutIfNeeded];
    
    CGSize titleSize = [model.Title strSizeWithFont:font(15)];
    CGSize desSize =[model.BusinessScope strSizeWithFont:font(13)];
    CGSize peopleSize =[model.PersonInfo strSizeWithFont:font(13)];
    self.height = baseH+titleSize.height+desSize.height+peopleSize.height+_cerH.constant-cellH+_imgH.constant;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    [tableView reloadData];
}

- (void)addImgurlsToCycleView
{
    NSMutableArray *imgUrls = [NSMutableArray array];
    if (_model.ImgUrl.length>0) {
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,_model.ImgUrl];
        [imgUrls addObject:imgUrl];
    }
    
    [_model.Qualifications enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgUrl = [obj objectForKey:@"ImgUrl"];
        if (imgUrl.length && imgUrl.length>0 ) {
            NSString *requestStr = [NSString stringWithFormat:@"%@%@",imgTestIP,imgUrl];
            [imgUrls addObject:requestStr];
        }
    }];
    _cycleView.imageURLStringsGroup = imgUrls;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (_cycleView.imageURLStringsGroup.count>0) {
        MQBrowserController *vc = [MQBrowserController new];
        vc.index = index;
        vc.imagUrls = _cycleView.imageURLStringsGroup;
        [_superVC presentViewController:vc animated:YES completion:nil];
    }
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
    NSDictionary *titleDic = _model.Qualifications[indexPath.row];
    NSString *title = [titleDic objectForKey:@"Title"];
    if (title.length>0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row+1,title];
    }
    
    return cell;
}

- (NSMutableAttributedString *)setAttriButiText:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    [attributedString addAttributes:@{
                                      NSFontAttributeName:font(11),
                                      NSForegroundColorAttributeName:[UIColor grayColor]
                                      } range:NSMakeRange(string.length-4, 4)];
    return attributedString;
 
}
@end
