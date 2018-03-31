//
//  MQGuessLikeCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQGuessLikeCell.h"
#import "MQGuessLikeModel.h"
#import "YZTagList.h"
#import "MQHeader.h"
#import "MQEqModel.h"
#import "MQTranShowModel.h"
@interface MQGuessLikeCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet YZTagList *listView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLead;
@property (weak, nonatomic) IBOutlet UIImageView *lableImgV;


@end
@implementation MQGuessLikeCell
- (void)awakeFromNib
{
    [super awakeFromNib];
   
}

- (CGFloat)imgWConst
{
    return 0;
}

-(CGFloat)titleLeadConst
{
    return 0;
}
//首页猜你喜欢模型
- (void)setModel:(MQGuessLikeModel *)model
{
    _model = model;
    _imgW.constant = 0;
    _titleLead.constant = 0;
    [_listView addTags:model.LABEL];
    _titleL.text = model.TITLE;
    _desL.text = model.DESCRIPTION;
    _timeLable.text = [self showTime: model.ADD_TIME ];
}

//股权收购列表详情模型
- (void)setEqModel:(MQEqModel *)eqModel
{
    _eqModel = eqModel;
    _imgW.constant = 0;
    _titleLead.constant = 0;
    NSMutableArray *lables = [NSMutableArray array];
    [eqModel.ShareExcellence enumerateObjectsUsingBlock:^(MQLabelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [lables addObject:obj.Name];
    }];
    [_listView deleteTags:lables];
    [_listView addTags:lables];
    
    _titleL.text = eqModel.Title;
    _desL.text = eqModel.Description;
    _timeLable.text = [self showTime: eqModel.AddTime ];
}

- (void)setTransModel:(MQTranShowModel *)transModel
{
    _transModel = transModel;
//    _imgW.constant = 80;
    _titleLead.constant = 10;
    _titleL.text = transModel.Title;
    _desL.text = [NSString stringWithFormat:@"注册资金:%@万",transModel.RegisteredCapital];
    _timeLable.text = [self showTime:transModel.AddTime];
    NSMutableArray *lables = [NSMutableArray array];
    [transModel.ShareExcellence enumerateObjectsUsingBlock:^(MQLabelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [lables addObject:obj.Name];
    }];
 
    [_listView addTags:lables];
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",imgTestIP,transModel.ImgUrl];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder100"]];
   
}

@end
