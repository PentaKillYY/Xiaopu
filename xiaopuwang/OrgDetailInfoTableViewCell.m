//
//  OrgDetailInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgDetailInfoTableViewCell.h"

@implementation OrgDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.orgName.text = [item getString:@"ChineseName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    self.viewCount.text = [NSString stringWithFormat:@"%d",arc4random()%500];
    self.focusCount.text =[NSString stringWithFormat:@"%d",arc4random()%500];
}

-(IBAction)clickMoreInfoAction:(id)sender{
    [self.delegate showMoreInfo:sender];
}
@end
