//
//  ReflectBannerTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ReflectBannerTableViewCell.h"

@implementation ReflectBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel{
    self.balanceLabel.text = [NSString stringWithFormat:@"$%.2f",[[UserInfo sharedUserInfo].userBalance doubleValue]];
}
@end
