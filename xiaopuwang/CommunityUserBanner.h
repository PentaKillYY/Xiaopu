//
//  CommunityUserBanner.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol CommunityUserBannerDelegate <NSObject>

-(void)showUserIdentityDelegate;
-(void)goToCollectDelegate;

@end

@interface CommunityUserBanner : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel* collectNumber;
@property(nonatomic,weak)IBOutlet UILabel* praiseNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trainingSpace;
@property(nonatomic,weak)IBOutlet UIImageView* userlogo;
@property(nonatomic,weak)IBOutlet UILabel* userName;
@property(nonatomic,weak)IBOutlet UILabel* userIdentity;
@property(nonatomic,weak)IBOutlet UIImageView* identityLogo;
@property(nonatomic,weak)IBOutlet UIButton* changeUserIdentity;
@property(nonatomic,assign)id<CommunityUserBannerDelegate>delegate;

-(IBAction)showUserIdentityAction;
-(IBAction)collectAction:(id)sender;
@end

