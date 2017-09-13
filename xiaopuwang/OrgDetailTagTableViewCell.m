//
//  OrgDetailTagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgDetailTagTableViewCell.h"

@implementation OrgDetailTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.leftTag.layer setBorderColor:MAINCOLOR.CGColor];
    [self.leftTag.layer setBorderWidth:0.5];
    [self.leftTag.layer setCornerRadius:3.0];
    [self.leftTag.layer setMasksToBounds:YES];
    self.leftTag.textColor = MAINCOLOR;
    
    [self.middleTag.layer setBorderColor:MAINCOLOR.CGColor];
    [self.middleTag.layer setBorderWidth:0.5];
    [self.middleTag.layer setCornerRadius:3.0];
    [self.middleTag.layer setMasksToBounds:YES];
    self.middleTag.textColor = MAINCOLOR;
    
    [self.rightTag.layer setBorderColor:MAINCOLOR.CGColor];
    [self.rightTag.layer setBorderWidth:0.5];
    [self.rightTag.layer setCornerRadius:3.0];
    [self.rightTag.layer setMasksToBounds:YES];
    self.rightTag.textColor = MAINCOLOR;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    
    
    
    if (![item getBool:@"IsOfficiallySettled"]) {
        self.leftTagW = 0;
    }
    
    if (![item getBool:@"IsOfficiallySettled"]) {
        self.middleTagW = 0;
    }
    
    self.middleTag.hidden = ![item getBool:@"IsTuitionSubsidy"];
    self.rightTag.hidden = ![item getBool:@"IsCourseGrading"];

}
@end
