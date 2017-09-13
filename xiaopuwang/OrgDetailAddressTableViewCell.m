//
//  OrgDetailAddressTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgDetailAddressTableViewCell.h"

@implementation OrgDetailAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.addressLabel.text = [item getString:@"DetailedAddress"];
    double nowDistance =  [self calculateWithX:[item getDouble:@"X"] Y:[item getDouble:@"Y"]];
    self.distanceLabel.text =  [NSString stringWithFormat:@"%.1f km",nowDistance];
}

-(double)calculateWithX:(double)x Y:(double)y{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    if (info.userLatitude && info.userLongitude) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[info.userLatitude floatValue] longitude:[info.userLongitude floatValue]];
        CLLocation *orgLocation = [[CLLocation alloc] initWithLatitude:fabs(y) longitude:fabs(x)];
        double distance = [currentLocation distanceFromLocation:orgLocation]/1000.0;
        return distance;
    }else{
        return 0.0;
    }
    
}

-(IBAction)showNavAction:(id)sender{
    [self.delegate navToAddress:sender];
}
@end
