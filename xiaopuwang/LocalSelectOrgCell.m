//
//  LocalSelectOrgCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "LocalSelectOrgCell.h"
@implementation LocalSelectOrgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.leftTag.textColor = MAINCOLOR;
    [self.leftTag.layer setBorderColor:MAINCOLOR.CGColor];
    [self.leftTag.layer setBorderWidth:0.5];
    self.leftTag.textInsets   = UIEdgeInsetsMake(2, 2, 2, 2); // 设置左内边距
    
    self.rightTag.textColor = SPECIALISTNAVCOLOR;
    [self.rightTag.layer setBorderColor:SPECIALISTNAVCOLOR.CGColor];
    [self.rightTag.layer setBorderWidth:0.5];
    self.rightTag.textInsets   = UIEdgeInsetsMake(2, 2, 2, 2); // 设置左内边距

    
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    
    
    self.orgName.preferredMaxLayoutWidth = Main_Screen_Width-110-59;
    self.orgName.numberOfLines = 0;
    self.orgName.text = [item getString:@"OrganizationName"];
    
    self.orgDistrict.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Area"],[item getString:@"City"],[item getString:@"Field"]];
    double nowDistance =  [self calculateWithX:[item getDouble:@"X"] Y:[item getDouble:@"Y"]];
    self.orgDistance.text = [NSString stringWithFormat:@"距您%.f公里",nowDistance];
    
    self.teachCourse.preferredMaxLayoutWidth = Main_Screen_Width-118;
    self.teachCourse.numberOfLines = 0;
    self.teachCourse.text = [item getString:@"TeachCourses"];
    
    StarRatingViewConfiguration *conf = [[StarRatingViewConfiguration alloc] init];
    conf.rateEnabled = NO;
    conf.starWidth = 15.0f;
    conf.fullImage = @"fullstar.png";
    conf.halfImage = @"halfstar.png";
    conf.emptyImage = @"emptystar.png";
    
    _starView.configuration = conf;
    [_starView setStarConfiguration];
    
    [_starView setRating:4.5 completion:^{
        NSLog(@"rate done");
    }];

}

-(double)calculateWithX:(double)x Y:(double)y{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[info.userLatitude floatValue] longitude:[info.userLongitude floatValue]];
    CLLocation *orgLocation = [[CLLocation alloc] initWithLatitude:fabs(y) longitude:fabs(x)];
    double distance = [currentLocation distanceFromLocation:orgLocation]/1000.0;
    return distance;
}
@end
