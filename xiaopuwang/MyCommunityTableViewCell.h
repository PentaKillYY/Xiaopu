//
//  MyCommunityTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyCommunityTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel* timeDay;
@property(nonatomic,weak)IBOutlet UILabel* timeMonth;
@property(nonatomic,weak)IBOutlet UILabel* communityTitle;
@property(nonatomic,weak)IBOutlet UILabel* praiseNumber;
@property(nonatomic,weak)IBOutlet UILabel* replyNumber;

-(void)bingdingViewModel:(DataItem*)item;
@end
