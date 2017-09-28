//
//  InviteSendTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface InviteSendTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* sendInviteButton;
@property(nonatomic,weak)IBOutlet UILabel* leftPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* rightPriceLabel;
@property(nonatomic,weak)IBOutlet UIView* priceBG;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* totalWidth;
-(void)setupInviteTotal:(DataResult* )result;
@end
