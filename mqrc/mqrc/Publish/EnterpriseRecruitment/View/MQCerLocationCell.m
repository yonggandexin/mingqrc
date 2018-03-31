//
//  MQCerLocationCell.m
//  mqrc
//
//  Created by 朱波 on 2017/12/14.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQCerLocationCell.h"

@implementation MQCerLocationCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle]loadNibNamed:@"MQIqSelectedCell" owner:nil options:nil][0];
        self.rightV.image = [UIImage imageNamed:@"position"];
        self.rightH.constant = self.rightW.constant = 20;
    }
    return self;
}

@end
