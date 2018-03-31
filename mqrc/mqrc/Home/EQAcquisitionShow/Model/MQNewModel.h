//
//  MQNewModel.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <Foundation/Foundation.h>
//"img_url" = "";
//"item_id" = D5681EAC1E364492B86F524E66E09D3F;
//key = "";
//title = "“时代天街，职等你来”大型综合招聘会";
//url = "";
@interface MQNewModel : NSObject

@property (nonatomic, copy) NSString *img_url;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;
@end
