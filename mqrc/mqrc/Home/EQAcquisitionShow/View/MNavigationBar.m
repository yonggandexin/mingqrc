//
//  MNavigationBar.m
//  mqrc
//
//  Created by 王满 on 2017/6/13.
//  Copyright © 2017年 kingman. All rights reserved.
//

#import "MNavigationBar.h"
#import "MQHeader.h"
static const NSInteger LeftButtonTag = 300;

@interface MNavigationBar()

@property (nonatomic, assign) MNavigationBarStyle style;
@property (nonatomic, strong) UIView *bgView;

@end


@implementation MNavigationBar


+ (instancetype)mMavigationBarWithStyle:(MNavigationBarStyle)style {
    MNavigationBar *bar = [[MNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    bar.style = style;
    return bar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
        gradientLayer.locations = @[@0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [_bgView.layer addSublayer:gradientLayer];
        [self addSubview:_bgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH-120, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setStyle:(MNavigationBarStyle)style {
    _style = style;
    if (_style == MNavigationBarStyleNormarl) {
        [self addBackItem];
    }
    else if (_style == MNavigationBarStyleHome || _style == MNavigationBarStyleHaveSearchLocal) {
        if (_style == MNavigationBarStyleHome)
            _bgView.alpha = 0;
        [self addBackItem];
        [self addSearch];
        [self addLocal];
    }
    else if (_style == MNavigationBarStyleCarInfo) {
        _bgView.alpha = 0;
        [self addBackItem];
    }
    else if (_style == MNavigationBarStyleHaveSearchPost){
        [self addBackItem];
        [self addSearch];
        [self addPost];
    }
    else if (_style == MNavigationBarStyleHaveSearchTextCancle){
        [self addBackItem];
        [self addSearchInput];
//        [self add];
    }
}

- (void)addBackItem {
    if (_style == MNavigationBarStyleNormarl || _style == MNavigationBarStyleHaveSearchLocal || _style == MNavigationBarStyleHaveSearchPost || _style == MNavigationBarStyleHaveSearchTextCancle) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 22,40,40);
        [leftBtn setImage:[UIImage imageNamed:@"nav_back_w"] forState:UIControlStateNormal];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
    }
    else if (_style == MNavigationBarStyleHome) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 27, 52, 30)];
        imageView.image = [UIImage imageNamed:@""];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
    }
    else if (_style == MNavigationBarStyleCarInfo) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(6, 24,36,36);
        [leftBtn setImage:[UIImage imageNamed:@"nav_back_w"] forState:UIControlStateNormal];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
        leftBtn.tag = 300;
        [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        leftBtn.layer.cornerRadius = 18;
        [self addSubview:leftBtn];
        
//        ic_more
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(SCREEN_WIDTH-42, 24,36,36);
        [_moreButton setImage:[UIImage imageNamed:@"ic_more"] forState:UIControlStateNormal];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
        [_moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        _moreButton.layer.cornerRadius = 18;
        [self addSubview:_moreButton];
    }
}

- (void)addSearch {
    CGFloat w = SCREEN_WIDTH*19.0/32.0;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2.0, 27, w, 30)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 15;
    button.alpha = 0.9;
    [button addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2.0+8, 33, 18, 18)];
    imageView.image = [UIImage imageNamed:@"search-index"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
}

- (void)addLocal {
    UIView *loaclView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 20, 65, 44)];
    _loaclLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 14, 36, 16)];
    _loaclLabel.textColor = [UIColor whiteColor];
    _loaclLabel.font = [UIFont systemFontOfSize:14];
    _loaclLabel.text = @"全国";
    [loaclView addSubview:_loaclLabel];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(42, 14, 15, 16)];
    imageView.image = [UIImage imageNamed:@"ar"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [loaclView addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 65, 44);
    [button addTarget:self action:@selector(localAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [loaclView addSubview:button];
    [self addSubview:loaclView];
}

- (void)addSearchInput{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(60, 27, SCREEN_WIDTH - 120, 30)];
    backView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    backView.layer.cornerRadius =  15;
    backView.clipsToBounds = YES;
    
    UIImageView *searchIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_white"]];
    searchIconImageView.frame = CGRectMake(10, 5, 20, 20);
    searchIconImageView. contentMode = UIViewContentModeCenter;
    [backView addSubview:searchIconImageView];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 , CGRectGetWidth(backView.frame) - 40, 20)];
    _searchTextField.backgroundColor = [UIColor clearColor];
    _searchTextField.borderStyle = UITextBorderStyleNone;
    _searchTextField.textColor = [UIColor whiteColor];
//    _searchTextField.placeholder = @"搜索";
//    [_searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
//    _searchTextField.textColor = [UIColor whiteColor];
//    _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
//    CGRect frame = [@"搜索" boundingRectWithSize:CGSizeMake(MAXFLOAT, _searchTextField.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
//    //设置textFiled的段落格式
    NSMutableParagraphStyle *style = [_searchTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
//    //设置垂直对齐
    style.minimumLineHeight = _searchTextField.font.lineHeight - (_searchTextField.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
//    //水平对齐
//    style.firstLineHeadIndent = (_textField.width - frame.size.width )*0.5 -DYNAMIC(20);
//    //设置placeholder的样式
    _searchTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]
        
        }];
    [backView addSubview:_searchTextField];
    [self addSubview:backView];
}

- (void)addPost{
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postButton.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 40, 40);
    [postButton setImage:[UIImage imageNamed:@"post"] forState:UIControlStateNormal];
    postButton.tag = 800;
    postButton.backgroundColor = [UIColor clearColor];
    [postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:postButton];
}

- (void)backAction {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(mNavigationBarBackAction)]) {
            [self.delegate mNavigationBarBackAction];
        }
        else
        [self.delegate.navigationController popViewControllerAnimated:YES];
    }
}

- (void)localAction {
    if ([self.delegate respondsToSelector:@selector(mNavigationBarLoactionAction)]) {
        [self.delegate mNavigationBarLoactionAction];
    }
}

- (void)searchAction {
    if ([self.delegate respondsToSelector:@selector(mNavigationBarSearchAction)]) {
        [self.delegate mNavigationBarSearchAction];
    }
}

- (void)postAction{
    if ([self.delegate respondsToSelector:@selector(mNavigationBarPostAction)]) {
        [self.delegate mNavigationBarPostAction];
    }
}

- (void)moreAction {
    if ([self.delegate respondsToSelector:@selector(mNavigationBarMoreAction)]) {
        [self.delegate mNavigationBarMoreAction];
    }
}

- (void)hidePostButton{
    UIButton *button = [self viewWithTag:800];
    button.hidden = YES;
}

- (void)changeToNormal{
    ((UIButton *)[self viewWithTag:LeftButtonTag]).backgroundColor = _moreButton.backgroundColor = [UIColor clearColor];
    self.bgView.alpha = 1;
}

- (void)changeAlphaWithCurrentOffset:(CGFloat)offsetY {
    if (_style == MNavigationBarStyleHome || _style == MNavigationBarStyleCarInfo) {
        if (offsetY <= 100) {
            self.bgView.alpha = 0;
            if (_style == MNavigationBarStyleCarInfo) {
                ((UIButton *)[self viewWithTag:LeftButtonTag]).backgroundColor = _moreButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
            }
        }
        else {
            CGFloat temp = (offsetY-100)*0.01;
            self.bgView.alpha = temp > 1? 1:temp;
            if (_style == MNavigationBarStyleCarInfo) {
                ((UIButton *)[self viewWithTag:LeftButtonTag]).backgroundColor = _moreButton.backgroundColor = [UIColor clearColor];
            }
        }
    }
    
//    if (_style == MNavigationBarStyleCarInfo) {
//        if (offsetY <= 50) {
//            self.bgView.alpha = 0;
//        }
//        else {
//            CGFloat temp = (offsetY-50)*0.01;
//            self.bgView.alpha = temp > 1? 1:temp;
//        }
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
