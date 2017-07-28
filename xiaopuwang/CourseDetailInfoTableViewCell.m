//
//  CourseDetailInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CourseDetailInfoTableViewCell.h"

@implementation CourseDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    self.coursePrice.text = [result.detailinfo getLong:@"Price"] == 0 ? @"议价": [NSString stringWithFormat:@"￥ %ld 元",[result.detailinfo getLong:@"Price"]];
    self.courseNumber.text = [NSString stringWithFormat:@"%ld",[result.detailinfo getLong:@"CourseSum"]];
    
    self.coursePeople.text = [result.detailinfo getString:@"Target"];
    
    self.courseTime.text = [result.detailinfo getString:@"ClassTimeStart"];
}
@end
