//
//  MyReplyCOmmunityTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyReplyCOmmunityTableViewCell.h"

@implementation MyReplyCOmmunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.replyBgView.layer setCornerRadius:5.0];
    [self.replyBgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.replyBgView.layer setBorderWidth:0.5];
    [self.replyBgView.layer setMasksToBounds:YES];
    
    self.replyTime.text = [[item getString:@"CreateTime"] substringToIndex:10];
    self.replyUserName.text = [item getString:@"UserName"];
    [self.replyUserLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"UserPhoto"]]] placeholderImage:nil];
    [self.replyUserLogo.layer setCornerRadius:10];
    [self.replyUserLogo.layer setMasksToBounds:YES];
    
    self.replyTitle.numberOfLines = 0;
    self.replyTitle.preferredMaxLayoutWidth = Main_Screen_Width-32;
    self.replyTitle.text =[item getString:@"NoteTitle"];
    
    NSString*ParentUserName;
    if ([item getString:@"ParentUserName"].length) {
        ParentUserName = [item getString:@"ParentUserName"];
    }else{
        ParentUserName = @"贴子";
    }

    NSString* picName;
    if ([item getString:@"ImageUrl"].length) {
        picName = @" [图片]";
    }else{
        picName = @"";
    }
    

    self.replyContent.text = [NSString stringWithFormat:@"回复 %@:%@%@",ParentUserName,[item getString:@"Content"],picName];

    
}
@end
