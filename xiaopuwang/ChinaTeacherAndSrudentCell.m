//
//  ChinaTeacherAndSrudentCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ChinaTeacherAndSrudentCell.h"

@implementation ChinaTeacherAndSrudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.nameLabel.text = [item getString:@"Name"];
    self.infoLabel.text = [item getString:@"Content"];
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"ImageUrl"]]] placeholderImage:nil];
}
@end
