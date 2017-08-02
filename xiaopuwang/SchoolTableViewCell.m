//
//  SchoolTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolTableViewCell.h"

@implementation SchoolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.sepH.constant = 0.5;
    self.leftTag.backgroundColor = MAINCOLOR;
    self.middleTag.backgroundColor = MAINCOLOR;
    self.rightTag.backgroundColor = MAINCOLOR;
    
    [self.leftTag.layer setCornerRadius:3.0];
    [self.middleTag.layer setCornerRadius:3.0];
    [self.rightTag.layer setCornerRadius:3.0];
    
    [self.leftTag.layer setMasksToBounds:YES];
    [self.middleTag.layer setMasksToBounds:YES];
    [self.rightTag.layer setMasksToBounds:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    
    if ([item getString:@"ChineseName"].length>0) {
        self.orgName.text = [item getString:@"ChineseName"];
        self.orgContent.text = [item getString:@"EnglishName"];
        [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
        self.distance.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"country_name"],[item getString:@"provinces_name"],[item getString:@"city_name"]];
        self.leftTag.text = @" 官方入驻 ";
        self.middleTag.text = @" 免费服务 ";
        self.rightTag.text = @" 学费补贴 ";
    }else{
        self.orgName.text = [item getString:@"SchoolName"];
        self.orgContent.text = nil;
        
         [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"SchoolLogo"]]] placeholderImage:nil];
        
        self.distance.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Province"],[item getString:@"City"],[item getString:@"Area"]];
        
        self.leftTag.text = @" 官方入驻 ";
        self.middleTag.text = @" 免费升学服务 ";
        self.rightTag.text = @" 学费补贴 ";
    }
    
}

@end
