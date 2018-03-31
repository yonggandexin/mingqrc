//
//  MQDropTypeView.h
//  mqrc
//
//  Created by 朱波 on 2017/11/30.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item,MQDropTypeView;
@protocol DropDelegate<NSObject>
- (void)dropView:(MQDropTypeView *)dropView reloadUIWithData:(Item *)item;
@end

typedef NS_ENUM(NSInteger, ItemStyle) {
    ItemStyleAcq,          //收购类型
    ItemStylePrice,         //收购价格
    ItemStyleTransferPrice,  //转让价格
    ItemStyleRegisterPrice,   //注册资金
    ItemSalary,   //薪资
    ItemRequirements, //任职要求
    ItemExperience, //工作年限
    ItemEducation,  //学历
    ItemJobWant,
    ItemSex
};

@interface MQDropTypeView : UIView
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, weak) id<DropDelegate> delegate;
@property (nonatomic, assign) ItemStyle dropStyle;
+ (instancetype)showWithItems:(NSArray *)items andDirection:(BOOL)isTop;
- (void)hide;
+ (void)dismissDropView;
@end


@interface Item :NSObject


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) ItemStyle selectStyle;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) NSString *Text;
@end
