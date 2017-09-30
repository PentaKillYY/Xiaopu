//
//  NoRedBagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "NoRedBagTableViewCell.h"

@implementation NoRedBagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.redBG.layer setCornerRadius:3.0];
    [self.redBG.layer setMasksToBounds:YES];
    
    [self.selectStateButton.layer setCornerRadius:10.0];
    [self.selectStateButton.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
