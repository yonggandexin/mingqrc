//
//  MQGuessLikeModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
//ADDRESS = "云南省昆明市高新技术开发区 海源北路六号高新招商大厦";
//"ADD_TIME" = "2017/11/22 17:02:49";
//"COMPANY_NAME" = "云南天度投资集团";
//DESCRIPTION = "注册资金:1000.00万";
//ID = A8517A115A714277A36C8BB8EDB3657B;
//"IS_TOP" = 1;
//LABEL =                 (
//);
//TITLE = "[天津市]ggggggggggg";
//TYPE = 0;
@interface MQGuessLikeModel : NSObject

@property (nonatomic, copy) NSString *ADDRESS;

@property (nonatomic, copy) NSString *ADD_TIME;

@property (nonatomic, copy) NSString *COMPANY_NAME;

@property (nonatomic, copy) NSString *DESCRIPTION;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger IS_TOP;

@property (nonatomic, strong) NSArray<NSString *> *LABEL;

@property (nonatomic, copy) NSString *TITLE;

@property (nonatomic, assign) NSInteger TYPE;

@end
