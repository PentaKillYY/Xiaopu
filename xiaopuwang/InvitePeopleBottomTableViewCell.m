//
//  InvitePeopleBottomTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InvitePeopleBottomTableViewCell.h"

@implementation InvitePeopleBottomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.commonLabel.layer setBorderWidth:1.0];
    [self.commonLabel.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.commonLabel.layer setCornerRadius:5.0];
    [self.commonLabel.layer setMasksToBounds:YES];
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
