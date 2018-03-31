//
//  MQTrainInfoModel.h
//  mqrc
//
//  Created by 朱波 on 2018/1/10.
//  Copyright © 2018年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTrainInfoModel : NSObject
//AddTime = "2017/05/12 10:14:49";
//DesCription = "";
//Time = "2\U4e2a\U6708";
//TimeSlot = "2017\U5e746\U670825\U65e5";
//Title = "\U5efa\U7b51\U8d77\U91cd\U53f8\U7d22\U4fe1\U53f7\U5de52017\U5e74\U4e8c\U671f\U57f9\U8bad\U73ed";
//WorkType = "\U5efa\U7b51\U8d77\U91cd\U53f8\U7d22\U4fe1\U53f7\U5de5";

@property (nonatomic, copy) NSString *AddTime;

@property (nonatomic, copy) NSString *DesCription;

@property (nonatomic, copy) NSString *Time;

@property (nonatomic, copy) NSString *TimeSlot;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *WorkType;


@end
