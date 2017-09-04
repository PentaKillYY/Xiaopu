//
//  TextViewTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/19.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TextViewTableViewCell.h"

@implementation TextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentTextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.contentTextView.layer setBorderWidth:0.5];
    [self.contentTextView.layer setCornerRadius:3.0];
    [self.contentTextView.layer setMasksToBounds:YES];
    self.contentTextView.backgroundColor = TEXTFIELD_BG_COLOR;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
