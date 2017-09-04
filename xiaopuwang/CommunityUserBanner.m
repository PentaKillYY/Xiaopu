//
//  CommunityUserBanner.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityUserBanner.h"

@implementation CommunityUserBanner

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.leadingSpace.constant = Main_Screen_Width/4-8;
    self.trainingSpace.constant = Main_Screen_Width/4-8;
    [self.userlogo.layer setCornerRadius:25];
    [self.userlogo.layer setMasksToBounds:YES];
    [self.userlogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[UserInfo sharedUserInfo].headPicUrl]] placeholderImage:nil];
    self.userName.text = [UserInfo sharedUserInfo].username;
    if ([UserInfo sharedUserInfo].userIdentity.length) {
        if ([[UserInfo sharedUserInfo].userIdentity isEqualToString:@"家长"]) {
            [self.identityLogo setImage:V_IMAGE(@"parent")];
        }else{
            [self.identityLogo setImage:V_IMAGE(@"student")];
        }
        self.userIdentity.text = [UserInfo sharedUserInfo].userIdentity;
        
    }else{
        self.userIdentity.text = @"普通用户";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)showUserIdentityAction{
    [self.delegate showUserIdentityDelegate];
}

-(IBAction)collectAction:(id)sender{
    [self.delegate goToCollectDelegate];
}
@end
