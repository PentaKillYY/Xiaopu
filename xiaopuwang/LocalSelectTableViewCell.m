//
//  LocalSelectTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "LocalSelectTableViewCell.h"

@implementation LocalSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)selectTagAction:(id)sender{
    [self.delegate localSelectChangeDelegate:sender];
}
@end
