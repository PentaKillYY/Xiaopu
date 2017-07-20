//
//  MainRollingTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainRollingTableViewCell.h"

@implementation MainRollingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // Configure the view for the selected state
    self.lineH.constant = 0.5;
    
    scrollView = [[AutoRollingScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.frame = CGRectMake(62, 5, Main_Screen_Width-62, 39);
    [self.contentView addSubview:scrollView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
