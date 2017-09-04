//
//  OrgClassTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgClassTableViewCell.h"

@implementation OrgClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingVieModel:(DataItem*)item{
    self.className.text = [item getString:@"CourseName"];
    self.classinfo.text = [item getString:@"CourseType"];
    [self.classLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"CoursePictureUrl"]]] placeholderImage:nil];
    self.classTarget.textColor = MAINCOLOR;
    self.classTarget.text = [NSString stringWithFormat:@"适合人群：%@",[item getString:@"Target"]];
}
@end
