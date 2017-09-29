//
//  GroupCourseDetailTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailTableViewCell.h"

@implementation GroupCourseDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.courseLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"CourseImage"]]] placeholderImage:nil];
    self.courseNameLabel.text = [item getString:@"CourseName"];
    self.groupPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"FightCoursePrice"]];
    self.saveLabel.text = [NSString stringWithFormat:@"省%.2f元",[item getDouble:@"OriginalPrice"]-[item getDouble:@"FightCoursePrice"]];
    self.groupStateLabel.text = [NSString stringWithFormat:@"已有%d人参与",[item getInt:@"FightCourseIsSignPeopleCount"]];
}
@end
