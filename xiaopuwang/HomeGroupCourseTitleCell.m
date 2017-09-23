//
//  HomeGroupCourseTitleCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "HomeGroupCourseTitleCell.h"

@implementation HomeGroupCourseTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.groupCourseTitle.textColor = GroupCourseRed;
    [self.groupCourseTag.layer setCornerRadius:5.0];
    [self.groupCourseTag.layer setMasksToBounds:YES];
    self.groupCourseTag.backgroundColor = GroupCourseRed;
    self.groupCourseTag.textColor = [UIColor whiteColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
