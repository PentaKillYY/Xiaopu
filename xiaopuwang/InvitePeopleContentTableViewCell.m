//
//  InvitePeopleContentTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InvitePeopleContentTableViewCell.h"

@implementation InvitePeopleContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentBgView.layer setBorderWidth:1.0];
    [self.contentBgView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.contentBgView.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
