//
//  MainServiceTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainServiceTableViewCell.h"

@implementation MainServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [self setupUI];
}

- (void)setupUI{
    self.lineH.constant = 0.5;
    self.lineH2.constant = 0.5;
    [self.specialistBtn setBackgroundImage:[UIImage imageNamed:@"英才奖学金"] forState:0];
    [self.personalBtn setBackgroundImage:[UIImage imageNamed:@"专家选校"] forState:0];
}

-(IBAction)serviceAction:(id)sender{
    [self.delegate pushToServicePage:sender];
}
@end
