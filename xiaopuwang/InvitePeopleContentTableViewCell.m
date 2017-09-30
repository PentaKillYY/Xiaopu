//
//  InvitePeopleContentTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InvitePeopleContentTableViewCell.h"

@implementation InvitePeopleContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentBgView.layer setBorderWidth:1.0];
    [self.contentBgView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.contentBgView.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.phoneLabel.text =  [item getString:@"LoginName"].length>10?[NSString stringWithFormat:@"%@****%@",[[item getString:@"LoginName"] substringToIndex:3],[[item getString:@"LoginName"] substringWithRange:NSMakeRange([item getString:@"LoginName"].length-3, 3)]]:[item getString:@"LoginName"];
    self.timeLabel.text = [item getString:@"ModifyTime"] ;
}
@end
