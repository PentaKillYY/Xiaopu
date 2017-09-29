//
//  SpecialRedBagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SpecialRedBagTableViewCell.h"

@implementation SpecialRedBagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.orgLogo.layer setCornerRadius:10];
    [self.orgLogo.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupred{
    self.bagPriceLabel.textColor = GroupCourseRed;
    self.bagPriceUnitLabel.textColor = GroupCourseRed;
    self.bagLogoImage.image = V_IMAGE(@"specialredbag");
    self.bagEndTimeLabel.text = @"有效期至2017-10-30";
    self.orgName.textColor = [UIColor blackColor];
    self.useButton.hidden = NO;
}

-(void)setupgray{
    self.bagPriceLabel.textColor = RedBagGray;
    self.bagPriceUnitLabel.textColor = RedBagGray;
    self.bagLogoImage.image = V_IMAGE(@"specialgraybag");
    self.bagEndTimeLabel.text = @"已失效";
    self.bagEndTimeLabel.textColor = RedBagGray;
    self.orgName.textColor = RedBagGray;
    self.useButton.hidden = YES;
}

-(void)bingdingViewModel:(DataItem*)item{
    self.bagPriceLabel.text = [NSString stringWithFormat:@"%d",[item getInt:@"Price"]] ;
    
    NSString* startTime =  [[item getString:@"CreateTime"] substringToIndex:10] ;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate *data = [format dateFromString:startTime];
    NSDate *nextDate = [NSDate dateWithTimeInterval:60*60*60 sinceDate:data];
    NSString *endTime = [format stringFromDate:nextDate];
    
    self.bagEndTimeLabel.text= [NSString stringWithFormat:@"有效期至:%@",endTime] ;
    self.orgName.text = [item getString:@"OrganizationName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"OrganizationLogo"]]] placeholderImage:nil];
}
@end
