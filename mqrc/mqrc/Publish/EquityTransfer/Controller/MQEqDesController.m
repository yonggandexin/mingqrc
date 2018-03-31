//
//  MQEqDesControllerViewController.m
//  mqrc
//
//  Created by 朱波 on 2017/11/27.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQEqDesController.h"
#import "MQHeader.h"
@interface MQEqDesController ()
@property (weak, nonatomic) IBOutlet STTextView *desTextView;
- (IBAction)btnClicked:(id)sender;

@end

@implementation MQEqDesController

- (void)viewDidLoad {
    [super viewDidLoad];

    _desTextView.text = _desText;
    _desTextView.placeholder = _placeStr;
    _desTextView.font = font(12);
    _desTextView.verticalSpacing = 5;
    _desTextView.maxHeight = 200;
}



- (IBAction)btnClicked:(id)sender {
    
    _textBlock(_desTextView.text);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
