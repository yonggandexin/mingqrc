//
//  MQeqLightsCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQeqLightsCell.h"
#import "MQHeader.h"
#import "MQEqHlightModel.h"
#import "MQJobWelfareModel.h"
@interface MQeqLightsCell()

@property (nonatomic, strong) UIImageView *backImgV;

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) UILabel *starL;
@end
@implementation MQeqLightsCell
-(NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *backImgV = [UIImageView new];
        backImgV.image = [UIImage imageNamed:@"rectangle"];
        backImgV.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 100);
        [self.contentView addSubview:backImgV];
        _backImgV = backImgV;
        
        _lable = [UILabel new];
        _lable.text = @"企业亮点";
        _lable.frame = CGRectMake(backImgV.x+12, backImgV.y, 70, 25);
        _lable.font = font(13);
        _lable.textAlignment = NSTextAlignmentLeft;
        _lable.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_lable];
        
        _starL = [UILabel new];
        _starL.textAlignment = NSTextAlignmentCenter;
        _starL.font = font(17);
        _starL.text = @"*";
        _starL.textColor = [UIColor redColor];
        _starL.center = CGPointMake(15, _lable.y+_lable.height*0.5+3);
        _starL.bounds = CGRectMake(2, 0, 10, 12);
        [self.contentView addSubview:_starL];
    }
    return self;
}

- (void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    _starL.hidden = !isShow;
}

- (void)setHLights:(NSArray <MQEqHlightModel *>*)hLights
{
    _hLights = hLights;
    [self creatBtn:hLights];
}

- (void)setObWelfares:(NSArray<MQJobWelfareModel *> *)obWelfares
{
    _obWelfares = obWelfares;
    [self creatBtn:obWelfares];
}

- (void)creatBtn:(NSArray *)models{
    
    if (_btns.count == models.count) {
        return;
    }
    for (int i = 0; i<models.count; i++) {
        UIButton *btn = [UIButton  buttonWithType: UIButtonTypeCustom];
        
        CGFloat margin = 20;
        CGFloat linfW = 10;
        NSInteger row = 4;
        
        btn.width = (SCREEN_WIDTH-2*margin-(row-1)*linfW)/4;
        btn.height = 20;
        btn.x = (i%4)*(btn.width+linfW)+margin;
        btn.y = (i/4) * (linfW+btn.height)+CGRectGetMaxY(_lable.frame)+5;
        btn.titleLabel.font = font(10);
        [btn setBackgroundImage:[UIImage imageNamed:@"Unfilled"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Fill"] forState:UIControlStateSelected];
        [btn setTitleColor:mainColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([[models firstObject] isKindOfClass:[MQEqHlightModel class]]) {
            MQEqHlightModel *model = models[i];
            [btn setTitle:model.Name forState:UIControlStateNormal];
        }else if ([[models firstObject] isKindOfClass:[MQJobWelfareModel class]]){
            MQJobWelfareModel *model = models[i];
            [btn setTitle:model.Name forState:UIControlStateNormal];
        }
        
        btn.tag = i+1000;
        [self.contentView addSubview:btn];
        [self.btns addObject:btn];
    }
//    UIButton *btn = [self.btns lastObject];
//    _backImgV.height = CGRectGetMaxY(btn.frame)+50;
    
}

- (void)btnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSInteger index = btn.tag-1000;
    if (_hLights.count>0) {
        MQEqHlightModel *modle = _hLights[index];
        modle.isSel = btn.selected;
    }else if(_obWelfares.count>0){
        MQJobWelfareModel *model = _obWelfares[index];
        model.isSelscted = btn.selected;
    }
}
@end
