//
//  OrgClassTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgClassTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* className;
@property(nonatomic,weak)IBOutlet UILabel* classinfo;
@property(nonatomic,weak)IBOutlet UIImageView* classLogo;
@property(nonatomic,weak)IBOutlet UILabel* classTarget;
@property(nonatomic,weak)IBOutlet UIImageView* classTargetLogo;

-(void)bingdingVieModel:(DataItem*)item;
@end
