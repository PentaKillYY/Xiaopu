//
//  GroupCourseShareTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseShareTableViewCell.h"

@implementation GroupCourseShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contactBotton.layer setCornerRadius:5.0];
    [self.contactBotton.layer setMasksToBounds:YES];
    
    [self.shareButton.layer setCornerRadius:5.0];
    [self.shareButton.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.remainPeopleLabel.text = [NSString stringWithFormat:@"仅剩%d个名额，快邀请好友来参团吧",[item getInt:@"FightCoursePeopleCount"]-[item getInt:@"FightCourseIsSignPeopleCount"]];
}

-(IBAction)contactOrgAction:(id)sender{
    [self.delegate contactOrgDelegate:sender];
}

-(IBAction)shareOrgAction:(id)sender{
    [self.delegate shareOrgDelegate:sender];
}
@end
