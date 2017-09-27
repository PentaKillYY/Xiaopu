//
//  WalletBannerTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol WallectCellDelegate <NSObject>

-(void)detailDelegate:(id)sender;

@end

@interface WalletBannerTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* detailButton;
@property(nonatomic,weak)IBOutlet UILabel* balanceLabel;
@property(nonatomic,assign)id<WallectCellDelegate>delegate;

-(IBAction)detailAction:(id)sender;

@end

