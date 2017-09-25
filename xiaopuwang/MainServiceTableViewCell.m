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
    self.leadingSpace.constant = (Main_Screen_Width-240)/4;
    self.trainingSpace.constant =( Main_Screen_Width-240)/4;
    self.sepHeight.constant = 0.5;
}



-(IBAction)serviceAction:(id)sender{
    [self.delegate pushToServicePage:sender];
}
@end
