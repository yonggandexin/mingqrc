//
//  MQResaultView.m
//  mqrc
//
//  Created by 朱波 on 2017/11/25.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQResaultView.h"
#import "MQHeader.h"
#import "MQSubCerModel.h"
#import "MQPosCerModel.h"
@interface MQResaultView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@end
@implementation MQResaultView
- (NSMutableArray *)models
{
    if (!_models ) {
        _models = [NSMutableArray array];
    }
    return _models;
}
+(instancetype)show:(NSArray *)models
{
    
    MQResaultView *view = [[MQResaultView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withModels:models];
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1;
    }];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame withModels:(NSArray *)models
{
    if (self = [super initWithFrame:frame]) {
        [self.models addObjectsFromArray:models];
        _contentV = [UIView new];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.frame = CGRectMake(30, 100,  SCREEN_WIDTH-60, SCREEN_HEIGHT-190);
        _contentV.layer.cornerRadius = 8;
        _contentV.layer.masksToBounds = YES;
        [self addSubview:_contentV];
        
        UILabel *titleL =  [UILabel new];
        titleL.backgroundColor = [UIColor whiteColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.text = @"已选资质证书";
        titleL.frame = CGRectMake(0, 10,_contentV.width, 30);
        titleL.font = font(14);
        [_contentV addSubview:titleL];
        _titleL = titleL;
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(titleL.x, CGRectGetMaxY(titleL.frame), titleL.width, _contentV.height-90) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [_contentV addSubview:tableView];
        [tableView registerCellName:[UITableViewCell class]];
        
        
        _btn = [MQBaseSureBtn buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(10, CGRectGetMaxY(tableView.frame)+10, _contentV.width-20, 35);
        [_btn setTitle:@"修改" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentV addSubview:_btn];
        
    }
    return self;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
    
}

- (void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnClicked:(UIButton *)btn
{
    [self hide];
    if (_delegate &&[_delegate respondsToSelector:@selector(goCheckAlreadyData)]) {
        [_delegate goCheckAlreadyData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if ([[self.models firstObject] isKindOfClass:[MQSubCerModel class]]) {
        MQSubCerModel *model = self.models[indexPath.row];
        cell.textLabel.text = model.Name;
    }else if ([[self.models firstObject] isKindOfClass:[MQPosCerModel class]]){
        MQPosCerModel *model = self.models[indexPath.row];
        cell.textLabel.text = model.Name;
    }
    cell.textLabel.font = font(13);
    return cell;
}
@end
