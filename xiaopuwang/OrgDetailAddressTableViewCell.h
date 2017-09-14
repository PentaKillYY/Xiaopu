//
//  OrgDetailAddressTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol OrgDetailAddressDelegate <NSObject>

-(void)navToAddress:(id)sender;

@end

@interface OrgDetailAddressTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* addressLabel;
@property(nonatomic,weak)IBOutlet UILabel* distanceLabel;
@property(nonatomic,weak)IBOutlet UIButton* mapButton;
@property(nonatomic,assign)id<OrgDetailAddressDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;
-(IBAction)showNavAction:(id)sender;
@end

