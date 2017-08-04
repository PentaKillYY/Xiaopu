//
//  SchoolBasicInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SchoolBasicInfoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* scoreTitleLabel;
@property(nonatomic,weak)IBOutlet UILabel* scoreLabel;
@property(nonatomic,weak)IBOutlet UILabel* applyStartLabel;
@property(nonatomic,weak)IBOutlet UILabel* applyEndLabel;

-(void)bingdngViewModel:(DataItem*)item;
@end
