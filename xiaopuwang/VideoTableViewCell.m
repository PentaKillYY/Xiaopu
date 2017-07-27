//
//  VideoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.videoName.text = [item getString:@"VideoName"];
    [self.videoLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"VideoPictureUrl"]]] placeholderImage:nil];
}
@end
