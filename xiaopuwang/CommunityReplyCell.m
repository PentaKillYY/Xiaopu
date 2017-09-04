//
//  CommunityReplyCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityReplyCell.h"

@implementation CommunityReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.replyLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"UserPhoto"]]] placeholderImage:nil];
    [self.replyLogo.layer setCornerRadius:12.5];
    [self.replyLogo.layer setMasksToBounds:YES];
    
    self.replyUserName.text = [item getString:@"UserName"];
    self.replyTime.text = [[item getString:@"CreateTime"] substringToIndex:10];
    self.replyContent.numberOfLines = 0;
    self.replyContent.preferredMaxLayoutWidth = Main_Screen_Width-48;
    NSString*ParentUserName;
    if ([item getString:@"ParentUserName"].length) {
        ParentUserName = [item getString:@"ParentUserName"];
    }else{
        ParentUserName = @"楼主";
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复 %@:%@",ParentUserName,[item getString:@"Content"]]];
    NSInteger firstlength = [NSString stringWithFormat:@"回复 %@:",ParentUserName].length;
    NSInteger totalLength = [NSString stringWithFormat:@"回复 %@:%@",ParentUserName,[item getString:@"Content"]].length;
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,firstlength)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(firstlength,totalLength-firstlength)];
    self.replyContent.attributedText = str;
    
    if ([item getString:@"ImageUrl"].length) {
        self.replyImageHeight.constant = (Main_Screen_Width-64-20)/3;
    }else{
        self.replyImageHeight.constant = 0;
    }
}
@end
