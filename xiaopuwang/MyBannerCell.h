//
//  MyBannerCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol UserLogoDelegate <NSObject>

-(void)changeUserLogo:(id)sender;

@end

@interface MyBannerCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* bgImage;
@property(nonatomic,weak)IBOutlet UIButton* userLogo;
@property(nonatomic,weak)IBOutlet UILabel* userName;
@property(nonatomic,assign)id<UserLogoDelegate>delegate;
@property(nonatomic,weak)IBOutlet UILabel* balance;


-(IBAction)userLogoAction:(id)sender;

@end

