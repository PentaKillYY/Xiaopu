//
//  SchoolDetailTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolDetailTableViewCell.h"

@implementation SchoolDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.chineseName.text = [item getString:@"ChineseName"];
    self.englishName.text = [item getString:@"EnglishName"];
       
    [self.schoolLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    
    self.schoolAddress.text = [NSString stringWithFormat:@"%@%@%@",[item getString:@"Country"],[item getString:@"Province"],[item getString:@"City"]];
    self.schoolWebsite.text = [item getString:@"Website"];
}

@end
