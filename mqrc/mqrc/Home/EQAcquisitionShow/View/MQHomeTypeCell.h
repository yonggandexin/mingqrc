//
//  MQHomeTypeCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MQHomeTypeDelegate<NSObject>
- (void)goToNextFunc:(NSInteger)index;
@end
@interface MQHomeTypeCell : UITableViewCell
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger totail;
@property (nonatomic, assign) NSInteger titleFont;
@property (nonatomic, weak) id <MQHomeTypeDelegate>delegate;

@end
