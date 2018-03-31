//
//  MQResumeView.m
//  mqrc
//
//  Created by 朱波 on 2018/1/2.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import "MQResumeView.h"
#import "MQHeader.h"
#import "MQResumeScanlCell.h"
#import "MQResumeModel.h"
#import "MQResumeScrolCell.h"
#import "TXScrollLabelView.h"
#import "MQResaultView.h"
#import "MQHopeAddressModel.h"
#define cell_H 35
@interface MQResumeView()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSArray *personArr;
@property (nonatomic, strong) NSArray *interArr;
@property (nonatomic, strong) UITableView *personTbv;
@property (nonatomic, strong) UITableView *interTabV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UIImageView *headV;
@property (nonatomic, strong) UIImageView *sexV;
@property (nonatomic, strong) UILabel *birthLable;
@end
@implementation MQResumeView
- (NSArray *)personArr
{
    return @[@"工作年限",@"户口所在地",@"现居住城市",@"学历",@"手机号码",@"邮箱",@"微信"];
}

- (NSArray *)interArr
{
    return @[@"求职类型",@"个人证书",@"期望职位",@"期望工作城市",@"期望薪酬"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.showsHorizontalScrollIndicator = NO;
        
        [self addPersonView];
        
        [self addIntentionView];
    }
    return self;
}

- (void)addPersonView
{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, self.personArr.count*cell_H+110) style:UITableViewStylePlain];
    tableView.tag = 100;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView .contentInset = UIEdgeInsetsMake(110, 0, 0, 0);
    tableView.layer.cornerRadius = 10;
    tableView.layer.masksToBounds = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    [tableView registerCellNibName:[MQResumeScanlCell class]];
    _personTbv = tableView;
    
    UIImageView *headV = [[UIImageView alloc]init];
    headV.width = 100;
    headV.height = 100;
    headV.layer.cornerRadius = headV.width*0.5;
    headV.layer.masksToBounds = YES;
    headV.centerX = SCREEN_WIDTH*0.5;
    headV.centerY = tableView.y;
    [self addSubview:headV];
    _headV = headV;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [self addSubview:label];
    _nameL = label;

    UIImageView *sexV = [[UIImageView alloc]init];
    [self addSubview:sexV];
    _sexV = sexV;
    
    UILabel *birthLable = [UILabel new];
    birthLable.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    birthLable.font = font(15);
    birthLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:birthLable];
    _birthLable = birthLable;
}


- (void)addIntentionView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_personTbv.frame)+20, SCREEN_WIDTH-20, self.interArr.count*cell_H+50) style:UITableViewStylePlain];
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.layer.cornerRadius = 10;
    tableView.layer.masksToBounds = YES;
    tableView.tag = 101;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    [tableView registerCellNibName:[MQResumeScanlCell class]];
    [tableView registerCellNibName:[MQResumeScrolCell class]];
    _interTabV = tableView;
    
    UILabel *lable = [UILabel new];
    lable.frame = CGRectMake(0, 0, tableView.width, 50);
    lable.text = @"求职意向";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    tableView.tableHeaderView = lable;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 100){
        return self.personArr.count;
    }else{
        return self.interArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    if (indexPath.row == 1 && tableView.tag == 101) {
        cellID = NSStringFromClass([MQResumeScrolCell class]);
    }else{
        cellID = NSStringFromClass([MQResumeScanlCell class]);
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableView.tag == 100) {
        MQResumeScanlCell *perCell = (MQResumeScanlCell *)cell;
        perCell.titleL.text = [NSString stringWithFormat:@"%@:",self.personArr[indexPath.row]];
        switch (indexPath.row) {
            case 0:
            {
                perCell.contentL.text = Experience[_model.WorkTime];
            }
                break;
             case 1:
            {
                perCell.contentL.text = _model.HomeTown;
            }
                break;
            case 2:
            {
                perCell.contentL.text = _model.LiveAddress;
            }
                break;
            case 3:
            {
                perCell.contentL.text = _model.MaxEducation;
            }
                break;
            case 4:
            {
                perCell.contentL.text = _model.Phone;
            }
                break;
            case 5:
            {
                perCell.contentL.text = _model.Email;
            }
                break;
            case 6:
            {
                perCell.contentL.text = _model.Wechat.length>0?_model.Wechat:@"无";
            }
                break;
                
            default:
                break;
        }
    }else{
        if (indexPath.row == 1) {
            MQResumeScrolCell *scrolV = (MQResumeScrolCell *)cell;
            scrolV.cers = _model.Qualicafitions;
            
        }else{
            MQResumeScanlCell *perCell = (MQResumeScanlCell *)cell;
            perCell.titleL.text = [NSString stringWithFormat:@"%@:",self.interArr[indexPath.row]];
            switch (indexPath.row) {
                case 0:
                {
                    perCell.contentL.text = _model.JobType;
                }
                    break;
                case 2:
                {
                    perCell.contentL.text = _model.Position.Name;
                }
                    break;
                case 3:
                {
                    perCell.contentL.text = [NSString stringWithFormat:@"%@ %@",_model.WorkProvince.Name,_model.WorkCity.Name];
                }
                    break;
                case 4:
                {
                    perCell.contentL.text = SalaryState[_model.Salary];
                }
                    break;
                default:
                    break;
            }
        }
        
    }
    return cell;
}


- (void)setModel:(MQResumeModel *)model
{
    _model = model;
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,model.ImgUrl];
    [_headV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder100"]];
    
    NSDictionary *attributes = @{NSFontAttributeName:_nameL.font};
    CGSize textSize = [model.Name boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _nameL.x = (self.width-textSize.width)*0.5;
    _nameL.y = CGRectGetMaxY(_headV.frame)+10;
    _nameL.size = textSize;
    _nameL.text = model.Name;
    
    _sexV.x = CGRectGetMaxX(_nameL.frame);
    _sexV.y = _nameL.y-2;
    _sexV.width = 18;
    _sexV.height = 25;
    
    if ([model.Sex isEqualToString:@"男"]) {
        _sexV.image = [UIImage imageNamed:@"MaleSign"];
    }else{
        _sexV.image = [UIImage imageNamed:@"Female sign"];
    }
    
    _birthLable.width = 100;
    _birthLable.height = 25;
    _birthLable.x = (self.width-_birthLable.width)*0.5;
    _birthLable.y = CGRectGetMaxY(_sexV.frame);
    _birthLable.text = model.BirthDay;
    
    [_personTbv reloadData];
    [_interTabV reloadData];
    
}
@end
