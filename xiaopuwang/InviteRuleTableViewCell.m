//
//  InviteRuleTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InviteRuleTableViewCell.h"

@implementation InviteRuleTableViewCell

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


-(void)bingdingViewModel{
    
    self.ruleTitle.preferredMaxLayoutWidth = Main_Screen_Width-48;
    self.ruleTitle.numberOfLines = 0;
    self.ruleTitle.text = InviteRule;
}
@end
