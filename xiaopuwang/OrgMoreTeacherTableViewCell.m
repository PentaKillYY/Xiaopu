//
//  OrgMoreTeacherTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMoreTeacherTableViewCell.h"

@implementation OrgMoreTeacherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.teacherName.text = [item getString:@"TeacherName"];
    self.teacherInfo.text = [NSString stringWithFormat:@"简介:%@",[item getString:@"Introduction"]];
    self.teacherInfo.preferredMaxLayoutWidth = Main_Screen_Width-94;

    self.teacherGoodCourse.text = [NSString stringWithFormat:@"擅长科目:%@",[item getString:@"GoodCourses"]];
    [self.teacherLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoUrl"]]] placeholderImage:nil];
    if ([item getBool:@"IsOversea"]) {
        self.teacherBackground.text = @"海归背景:海归";
    }else{
        self.teacherBackground.text = @"海归背景:非海归";
    }
    self.teacherCareer.text = [NSString stringWithFormat:@"教龄:%@",[item getString:@"TeachingAge"]];
}

@end
