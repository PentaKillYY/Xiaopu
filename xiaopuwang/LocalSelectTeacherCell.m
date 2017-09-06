//
//  LocalSelectTeacherCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "LocalSelectTeacherCell.h"

@implementation LocalSelectTeacherCell

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
    [self.teacherLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoUrl"]]] placeholderImage:nil];
    self.teacherOrg.text = [item getString:@"ChineseName"];
    self.teacherCareer.text = [item getString:@"TeachingAge"];
    self.teacherIntro.text = [item getString:@"Introduction"];
    [self.teacherLogo.layer setCornerRadius:2.0];
    [self.teacherLogo.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.teacherLogo.layer setBorderWidth:0.5];
    [self.teacherLogo.layer setMasksToBounds:YES];
    
    self.teacherOrg.textColor = MAIN_LIGHT_TEXT_COLOR;
    self.teacherCareer.textColor = MAIN_LIGHT_TEXT_COLOR;
    self.teacherIntro.textColor = MAIN_LIGHT_TEXT_COLOR;
}
@end
