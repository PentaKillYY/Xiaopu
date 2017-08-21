//
//  PayTypeTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PayTypeTableViewCell.h"

@implementation PayTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.aliPayButton setImage:V_IMAGE(@"roundCheck") forState:UIControlStateNormal];
    [self.aliPayButton setImage:V_IMAGE(@"roundCheckSelected") forState:UIControlStateSelected];
    
    self.aliPayButton.selected  = YES;
    
    [self.wxPayButton setImage:V_IMAGE(@"roundCheck") forState:UIControlStateNormal];
    [self.wxPayButton setImage:V_IMAGE(@"roundCheckSelected") forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)alipaySelectAction:(id)sender{
    self.aliPayButton.selected = YES;
    self.wxPayButton.selected = NO;
    [self.delegate payTypeDelegate:sender];
}

-(IBAction)wxPaySelectAction:(id)sender{
    self.aliPayButton.selected = NO;
    self.wxPayButton.selected = YES;
    [self.delegate payTypeDelegate:sender];
}

@end
