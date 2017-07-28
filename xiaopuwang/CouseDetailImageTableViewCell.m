//
//  CouseDetailImageTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CouseDetailImageTableViewCell.h"

@implementation CouseDetailImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    [self.courseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[result.detailinfo getString:@"CoursePictureUrl"]]] placeholderImage:nil];
}
@end
