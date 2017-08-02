//
//  ChinaSchoolBannerTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/1.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ChinaSchoolBannerTableViewCell.h"

@implementation ChinaSchoolBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sepH.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)clickButton:(id)sender{
    [self.delegate bannerBubttonClicked:sender];
}
@end
