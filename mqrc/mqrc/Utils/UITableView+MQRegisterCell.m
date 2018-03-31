//
//  UITableView+MQRegisterCell.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "UITableView+MQRegisterCell.h"

@implementation UITableView (MQRegisterCell)
- (void)registerCellNibName:(Class)cellClass
{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellName:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)roloadCell:(NSInteger)section andRow:(NSInteger)row
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:section];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadSectionWithIndex:(NSInteger)section
{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
