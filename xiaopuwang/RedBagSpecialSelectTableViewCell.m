//
//  RedBagSpecialSelectTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "RedBagSpecialSelectTableViewCell.h"

@implementation RedBagSpecialSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.orgLogo.layer setCornerRadius:10];
    [self.orgLogo.layer setMasksToBounds:YES];
    [self.selectStateButton.layer setCornerRadius:10.0];
    [self.selectStateButton.layer setMasksToBounds:YES];
    [self setupred];

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
}

-(void)bingdingViewModel:(DataItem*)item{
    self.bagPriceLabel.text = [NSString stringWithFormat:@"%d",[item getInt:@"Price"]] ;
    
    NSString* startTime =  [[item getString:@"CreateTime"] substringToIndex:10] ;
    NSInteger validTime = [item getInt:@"ValidityTime"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate *data = [format dateFromString:startTime];
    NSDate *nextDate = [NSDate dateWithTimeInterval:validTime*24*60*60  sinceDate:data];
    NSString *endTime = [format stringFromDate:nextDate];
    
    self.bagEndTimeLabel.text= [NSString stringWithFormat:@"有效期至:%@",endTime] ;
    self.orgName.text = [item getString:@"OrganizationName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"OrganizationLogo"]]] placeholderImage:nil];
}


@end
