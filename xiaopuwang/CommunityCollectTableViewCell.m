//
//  CommunityCollectTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityCollectTableViewCell.h"

@implementation CommunityCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.communityReplyNumber.text = [item getString:@"CommunityUserReplyCount"];
    
    self.communityTitle.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.communityTitle.numberOfLines = 2;

    self.communityTitle.text = [item getString:@"Title"];
}
@end
