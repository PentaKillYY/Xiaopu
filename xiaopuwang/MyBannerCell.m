//
//  MyBannerCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyBannerCell.h"

@implementation MyBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.userLogo.layer setCornerRadius:28.0];
    [self.userLogo.layer setBorderWidth:3.0];
    [self.userLogo.layer setBorderColor:MAINCOLOR.CGColor];
    
    [self.userLogo.layer setMasksToBounds:YES];
    [self.userLogo sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:V_IMAGE(@"UserDefaultLogo")];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)userLogoAction:(id)sender{
    [self.delegate changeUserLogo:sender];
}

@end
