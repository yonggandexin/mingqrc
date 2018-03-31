//
//  MQDropTypeView.m
//  mqrc
//
//  Created by 朱波 on 2017/11/30.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQDropTypeView.h"
#import "MQHeader.h"
#define back_dru 0.2
#define content_dru 0.4
#define cell_H 35
#define cell_BH 45
@interface MQDropTypeView()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) CGFloat cellH;
@end
MQDropTypeView *dropView = nil;
@implementation MQDropTypeView

+ (instancetype)showWithItems:(NSArray *)items andDirection:(BOOL)isTop
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[MQDropTypeView class]]) {
            [((MQDropTypeView *)subView) hide];
            return nil;
        }
    }
    
    if (isTop == YES) {
        dropView = [[MQDropTypeView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100) withItems:items andDirection:isTop];
    }else{
        dropView = [[MQDropTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withItems:items andDirection:isTop];
    }
    dropView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.3];
    dropView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:dropView];
    [UIView animateWithDuration:back_dru animations:^{
        dropView.alpha = 1;
    }];
    return dropView;
}

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items andDirection:(BOOL)isTop
{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        _isTop = isTop;
        UIView *contentV = [UIView new];
        if (isTop == YES) {
            _cellH = cell_H;
             contentV.frame = CGRectMake(0, 0, self.width, 0);
             contentV.layer.masksToBounds = YES;
        }else{
            _cellH = cell_BH;
             contentV.frame = CGRectMake(0, self.height, self.width, items.count*_cellH);
        }
        [self addSubview:contentV];
        _contentV = contentV;
        
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, items.count*_cellH) style:UITableViewStylePlain];
        tabView.bounces = NO;
        if (_isTop == NO) {
            [tabView setSeparatorInset:UIEdgeInsetsZero];
        }
        tabView.delegate = self;
        tabView.dataSource = self;
        [contentV addSubview:tabView];
        [tabView registerCellName:[UITableViewCell class]];

        [UIView animateWithDuration:content_dru animations:^{
            if (isTop == YES) {
                _contentV.height =  items.count*_cellH;
            }else{
                _contentV.y = self.height-items.count*_cellH;
            }
            
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = _items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isTop == YES) {
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.font = font(13);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];

    if (_delegate &&[_delegate respondsToSelector:@selector(dropView:reloadUIWithData:)]) {
        Item *item = [Item new];
        [self.btn setTitle: _items[indexPath.row] forState:UIControlStateNormal];
        item.btn = self.btn;
        item.Text = _items[indexPath.row];
        item.index = indexPath.row;
        item.selectStyle = _dropStyle;
        [_delegate dropView:dropView reloadUIWithData:item];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self hide];
    
}

- (void)hide
{
    [UIView animateWithDuration:content_dru animations:^{
        if (_isTop == YES) {
            _contentV.height = 0;
        }else{
            _contentV.y = self.height;
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:back_dru animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

+ (void)dismissDropView
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[MQDropTypeView class]]) {
            [((MQDropTypeView *)subView) removeFromSuperview];
        }
    }
}
@end

@implementation Item


@end
