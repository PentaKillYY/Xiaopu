//
//  WalletBannerTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "WalletBannerTableViewCell.h"

@implementation WalletBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [self.couponButton setTitle:[NSString stringWithFormat:@"优惠券%@张",info.userCoupon] forState:UIControlStateNormal];
    self.balanceLabel.text = [NSString stringWithFormat:@"$%.2f",[info.userBalance doubleValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)couponAction:(id)sender{
    [self.delegate couponDelegate:sender];
}

-(IBAction)detailAction:(id)sender{
    [self.delegate detailDelegate:sender];
}

-(IBAction)reflectAction:(id)sender{
    [self.delegate reflectDelegate:sender];
}
@end
