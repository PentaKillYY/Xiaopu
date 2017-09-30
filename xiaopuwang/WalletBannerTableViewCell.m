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
    
    self.balanceLabel.text = [NSString stringWithFormat:@"%.2f",[info.userBalance doubleValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)detailAction:(id)sender{
    [self.delegate detailDelegate:sender];
}


@end
