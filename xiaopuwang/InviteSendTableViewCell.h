//
//  InviteSendTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol InviteSendDelegate <NSObject>

-(void)shareInvite:(id)sender;

@end

@interface InviteSendTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* sendInviteButton;
@property(nonatomic,weak)IBOutlet UILabel* leftPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* rightPriceLabel;
@property(nonatomic,weak)IBOutlet UIView* priceBG;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* totalWidth;
@property(nonatomic,assign)id<InviteSendDelegate>delegate;

-(void)setupInviteTotal:(DataResult* )result;

-(IBAction)sendInviteUrl:(id)sender;
@end


