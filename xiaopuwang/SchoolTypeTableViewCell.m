//
//  SchoolTypeTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolTypeTableViewCell.h"

@implementation SchoolTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.typeCount.layer setCornerRadius:2.0];
    [self.typeCount.layer setBackgroundColor:MAINCOLOR.CGColor];
    [self.typeCount.layer setMasksToBounds:YES];
    self.typeCount.textColor = [UIColor whiteColor];
    
    [self bingdingData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingData{
    self.typeCount.text = @"120";
    self.typeName.text = @"中国";
}
@end
