//
//  LocalSelectSchoolCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "LocalSelectSchoolCell.h"

@implementation LocalSelectSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftTag.textColor = MAINCOLOR;
    [self.leftTag.layer setBorderColor:MAINCOLOR.CGColor];
    [self.leftTag.layer setBorderWidth:0.5];
    self.leftTag.textInsets   = UIEdgeInsetsMake(2, 2, 2, 2); // 设置左内边距
    
    self.middleTag.textColor = [UIColor redColor];
    [self.middleTag.layer setBorderColor:[UIColor redColor].CGColor];
    [self.middleTag.layer setBorderWidth:0.5];
    self.middleTag.textInsets   = UIEdgeInsetsMake(2, 2, 2, 2); // 设置左内边距

    
    self.rightTag.textColor = SPECIALISTNAVCOLOR;
    [self.rightTag.layer setBorderColor:SPECIALISTNAVCOLOR.CGColor];
    [self.rightTag.layer setBorderWidth:0.5];
    self.rightTag.textInsets   = UIEdgeInsetsMake(2, 2, 2, 2); // 设置左内边距
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    if ([item getString:@"ChineseName"].length>0) {
        self.schoolName.text = [item getString:@"ChineseName"];
        self.schoolEngName.text = [item getString:@"EnglishName"];
        [self.schoolLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
        self.schoolDistrict.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"country_name"],[item getString:@"provinces_name"],[item getString:@"city_name"]];
        self.schoolCourse.text = [NSString stringWithFormat:@"%@ %@",[item getString:@"CollegeNatureText"],[item getString:@"CollegeTypeText"]];
       
    }else{
        self.schoolName.text = [item getString:@"SchoolName"];
        self.schoolEngName.text = nil;
        
        [self.schoolLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"SchoolLogo"]]] placeholderImage:nil];
        
        self.schoolDistrict.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Province"],[item getString:@"City"],[item getString:@"Area"]];
        self.schoolCourse.text = [NSString stringWithFormat:@"%@ %@",[item getString:@"CollegeNature"],[item getString:@"CollegeType"]];
     
    }

}
@end
