//
//  UITableView+MQRegisterCell.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MQRegisterCell)
- (void)registerCellNibName:(Class)cellClass;
- (void)registerCellName:(Class)cellClass;
- (void)roloadCell:(NSInteger)section andRow:(NSInteger)row;

- (void)reloadSectionWithIndex:(NSInteger)section;
@end
