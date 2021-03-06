//
//  MyAppiontOrderTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyAppiontOrderTableViewCell.h"

@implementation MyAppiontOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.orgName.text = [item getString:@"OrganizationName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    self.orgDistance.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Area"],[item getString:@"City"],[item getString:@"Field"]];
    self.orgChineseName.text = [item getString:@"ChineseName"];
    self.orgContent.preferredMaxLayoutWidth =Main_Screen_Width-74;
    self.orgContent.numberOfLines = 0;
    self.orgContent.text = [item getString:@"TeachCourses"];
    self.appointState.textColor = SPECIALISTNAVCOLOR;
    [self.cancelOrderButton.layer setCornerRadius:3.0];
    [self.cancelOrderButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cancelOrderButton.layer setBorderWidth:0.5];
    [self.cancelOrderButton.layer setMasksToBounds:YES];
    [self.cancelOrderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
    [self.dealOrderButton.layer setCornerRadius:3.0];
    [self.dealOrderButton.layer setBorderColor:MAINCOLOR.CGColor];
    [self.dealOrderButton.layer setBorderWidth:0.5];
    [self.dealOrderButton.layer setMasksToBounds:YES];
    [self.dealOrderButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
}

-(IBAction)deleteOrderAction:(id)sender{
    [self.delegate deleteOrderDelegate:sender];
}

-(IBAction)dealOrderAction:(id)sender{
    [self.delegate dealOrderDelegate:sender];
}
@end
