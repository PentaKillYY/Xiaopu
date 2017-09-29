//
//  MainCommunityTitleTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainCommunityTitleTableViewCell.h"

@implementation MainCommunityTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.hotLabel.layer setCornerRadius:5.0];
    [self.hotLabel.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
