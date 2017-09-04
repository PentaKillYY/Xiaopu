//
//  MyCommunityTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyCommunityTableViewCell.h"

@implementation MyCommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.praiseNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserGoodCount"]];
    self.replyNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserReplyCount"]];
    self.communityTitle.numberOfLines = 0;
    self.communityTitle.preferredMaxLayoutWidth = Main_Screen_Width-75;
    self.communityTitle.text = [item getString:@"Title"];
    self.timeDay.text = [[item getString:@"CreateTime"] substringWithRange:NSMakeRange(8, 2)];
    self.timeMonth.text = [NSString stringWithFormat:@"%@月",[[item getString:@"CreateTime"] substringWithRange:NSMakeRange(5, 2)]];
}
@end
