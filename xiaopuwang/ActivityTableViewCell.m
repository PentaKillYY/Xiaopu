//
//  ActivityTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self bingdingData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingData{
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:@"http://www.ings.org.cn/Uploads/Organization/20170715145035379927_Logo.png"] placeholderImage:nil];
}
@end
