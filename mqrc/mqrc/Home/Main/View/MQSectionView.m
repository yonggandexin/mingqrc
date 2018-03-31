//
//  MQSectionView.m
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#import "MQSectionView.h"
#import "MQHeader.h"
@interface MQSectionView()
@property (weak, nonatomic) IBOutlet UIButton *partBtn;
@property (weak, nonatomic) IBOutlet UIButton *transferBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomV;
@property (nonatomic, strong) UIButton *selectedTitleButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centX;
- (IBAction)transferClicked:(id)sender;

@end
@implementation MQSectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self transferClicked:_transferBtn];
}
- (IBAction)transferClicked:(UIButton *)sender
{
    self.selectedTitleButton.selected = NO;
    sender.selected = YES;
    self.selectedTitleButton = sender;
    if (_selectedBlock) {
        if (sender.tag == 1000) {
            _selectedBlock(transferStyle);
            if (_centX.constant>0) {
                [self scrollAnimation:0];
            }
        }else{
            _selectedBlock(jobWantedPartStyle);
            if (_centX.constant==0) {
                [self scrollAnimation:self.width*0.5];
            }
        }
    }
    
}

- (void)scrollAnimation:(CGFloat)centX
{
    [UIView animateWithDuration:0.5 animations:^{
        _centX.constant = centX;
        [self layoutIfNeeded];
    }];
}
@end
