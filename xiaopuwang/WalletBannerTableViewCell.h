//
//  WalletBannerTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol WallectCellDelegate <NSObject>

-(void)couponDelegate:(id)sender;
-(void)detailDelegate:(id)sender;
-(void)reflectDelegate:(id)sender;

@end

@interface WalletBannerTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* couponButton;
@property(nonatomic,weak)IBOutlet UIButton* detailButton;
@property(nonatomic,weak)IBOutlet UILabel* balanceLabel;
@property(nonatomic,weak)IBOutlet UIButton* reflectButton;
@property(nonatomic,assign)id<WallectCellDelegate>delegate;

-(IBAction)couponAction:(id)sender;
-(IBAction)detailAction:(id)sender;
-(IBAction)reflectAction:(id)sender;

@end

