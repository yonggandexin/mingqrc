//
//  MQCityController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/28.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQCityController.h"
#import "MQHeader.h"
#import "City.h"
@interface MQCityController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@end

@implementation MQCityController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"选择城市";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = baseColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerCellName:[MQBaseCell class]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = _citys[indexPath.row];
    MQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MQBaseCell class])];
    cell.textLabel.text = city.Name;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = font(15);
    [cell isFirst:NO andIsLast:(indexPath.row == _citys.count-1)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     City *city = _citys[indexPath.row];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (_region == ShareTypeAcquis) {
            NSNotification *noti = [NSNotification notificationWithName:Selected_city object:city];
            [MQNotificationCent postNotification:noti];
        }else if (_region == ShareTypeTrans){
            NSNotification *noti = [NSNotification notificationWithName:Selected_TransferCity object:city];
            [MQNotificationCent postNotification:noti];
        }
        
    }];
}
@end
