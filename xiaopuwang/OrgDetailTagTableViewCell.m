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
    
    [self.rightTag.layer setBorderColor:ORGGOLD.CGColor];
    [self.rightTag.layer setBorderWidth:0.5];
    [self.rightTag.layer setCornerRadius:3.0];
    [self.rightTag.layer setMasksToBounds:YES];
    self.rightTag.textColor = ORGGOLD;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.leftTagW.constant = 0;
    
    self.middleTag.hidden = ![item getBool:@"IsTuitionSubsidy"];
    
    self.rightTag.hidden = ![item getBool:@"Is30Day"];

}

-(void)bingdingGroupCourseModel:(BOOL)isGroupCourse{
    if (!isGroupCourse) {
        self.leftTagW.constant = 0;
    }else{
        self.leftTagW.constant = 63;
    }
}
@end
