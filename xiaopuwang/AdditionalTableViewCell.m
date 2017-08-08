//
//  AdditionalTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/8.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "AdditionalTableViewCell.h"

@implementation AdditionalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentTextField.backgroundColor = TEXTFIELD_BG_COLOR;
    
    self.contentTextField.placeholder = @"请选择该语言掌握程度";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)deleteAction:(id)sender{
    [self.delegate deleteAdditionalCell:sender];
}
@end
