//
//  MNavigationBar.h
//  mqrc
//
//  Created by 王满 on 2017/6/13.
//  Copyright © 2017年 kingman. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MNavigationBarStyleNormarl,  //含有title和返回
    MNavigationBarStyleHome,     //首页
    MNavigationBarStyleHaveSearchLocal, //搜索、返回和位置
    MNavigationBarStyleInfo,
    MNavigationBarStyleCarInfo,
    MNavigationBarStyleHaveSearchPost,   //搜索、返回和发布
    MNavigationBarStyleHaveSearchTextCancle //搜索输入、返回和取消按钮
} MNavigationBarStyle;


typedef void(^GetSelectJobSalary)(NSString *title, NSString *selectID);


@protocol MNavigationBarDelegate <NSObject>

@optional

- (void)mNavigationBarBackAction;

- (void)mNavigationBarSearchAction;

- (void)mNavigationBarPostAction;

- (void)mNavigationBarLoactionAction;

- (void)mNavigationBarMoreAction;

//- (void)mNavigationBar: inputText:(NSString *)inputText;

@end



@interface MNavigationBar : UIView

@property (nonatomic, strong) UILabel *loaclLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, assign) UIViewController <MNavigationBarDelegate> *delegate;

+ (instancetype)mMavigationBarWithStyle:(MNavigationBarStyle)style;

- (void)changeAlphaWithCurrentOffset:(CGFloat)offsetY;

- (void)changeToNormal;

- (void)hidePostButton;


@property (nonatomic, strong) UIButton *moreButton;

@end
