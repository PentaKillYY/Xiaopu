//
//  OrgStudentTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgStudentTableViewCell.h"

@implementation OrgStudentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.studentName.text = [item getString:@"Student_Name"];
    self.studentContent.text = [item getString:@"Summary"];
    [self.studentLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoUrl"]]] placeholderImage:nil];
}

@end
