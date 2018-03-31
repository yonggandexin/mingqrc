//
//  MQPushModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/16.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,pushModelType){
    TransferCkeck,    //股权转让企业审核
    JobCompanyCheck,  //企业招聘企业认证
    UserIdentityCheck //企业招聘用户认证
};
@interface MQPushModel : NSObject

@property (nonatomic, assign) pushModelType PushType;
/**
 0审核失败,1审核成功
 */
@property (nonatomic, assign) NSInteger StateCheck;

@property (nonatomic, copy) NSString *DataId;


@end
