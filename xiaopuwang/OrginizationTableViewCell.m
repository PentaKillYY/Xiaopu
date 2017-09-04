//
//  OrginizationTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationTableViewCell.h"

@implementation OrginizationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code


    self.sepH.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

-(void)bingdingViewModel:(DataItem*)item{
    [self setupTagView];

    
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]] ] placeholderImage:nil];

    self.orgContent.text = [item getString:@"TeachCourses"];
    self.orgContent.preferredMaxLayoutWidth = Main_Screen_Width-111;
    
    
    self.orgName.text = [item getString:@"OrganizationName"];
    self.leftTag.hidden = ![item getBool:@"IsOfficiallySettled"];
    
    double nowDistance =  [self calculateWithX:[item getDouble:@"X"] Y:[item getDouble:@"Y"]];
    
    self.distance.text = [NSString stringWithFormat:@"%@-%@-%@ 距您%.1f km",[item getString:@"Area"],[item getString:@"City"],[item getString:@"Field"],nowDistance];

    
    if (![item getBool:@"IsOfficiallySettled"]) {
        self.leftTagW = 0;
    }
    
    if (![item getBool:@"IsOfficiallySettled"]) {
        self.middleTagW = 0;
    }
    
    self.middleTag.hidden = ![item getBool:@"IsTuitionSubsidy"];
    self.rightTag.hidden = ![item getBool:@"IsCourseGrading"];
    
}

- (void)setupTagView
{
    
    self.leftTag.backgroundColor = MAINCOLOR;
    self.middleTag.backgroundColor = MAINCOLOR;
    self.rightTag.backgroundColor = MAINCOLOR;
    
    [self.leftTag.layer setCornerRadius:3.0];
    [self.middleTag.layer setCornerRadius:3.0];
    [self.rightTag.layer setCornerRadius:3.0];
    
    [self.leftTag.layer setMasksToBounds:YES];
    [self.middleTag.layer setMasksToBounds:YES];
    [self.rightTag.layer setMasksToBounds:YES];
    
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
