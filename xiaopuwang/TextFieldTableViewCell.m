//
//  TextFieldTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/19.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentField.backgroundColor = TEXTFIELD_BG_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
