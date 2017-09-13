//
//  OrgDetailAddressTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgDetailAddressTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* addressLabel;
@property(nonatomic,weak)IBOutlet UILabel* distanceLabel;
@property(nonatomic,weak)IBOutlet UIButton* mapButton;

-(void)bingdingViewModel:(DataItem*)item;
@end
