//
//  MyFollowSchoolCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyFollowSchoolCell.h"

@implementation MyFollowSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem *)item{
    if ([item getString:@"ChineseName"].length>0) {
        self.schoolName.text = [item getString:@"ChineseName"];
        self.schoolEnglishName.text = [item getString:@"EnglishName"];
        [self.logoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
        self.posotion.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Country"],[item getString:@"Province"],[item getString:@"City"]];
       
    }else{
        self.schoolName.text = [item getString:@"SchoolName"];
        self.schoolEnglishName.text = nil;
        
        [self.logoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"SchoolLogo"]]] placeholderImage:nil];
        
        self.posotion.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Province"],[item getString:@"City"],[item getString:@"Area"]];
    }

}
@end
