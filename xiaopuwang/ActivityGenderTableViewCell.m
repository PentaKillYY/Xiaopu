//
//  ActivityGenderTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ActivityGenderTableViewCell.h"

@implementation ActivityGenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.radio1 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [self.radio1 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    
    [self.radio2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [self.radio2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
