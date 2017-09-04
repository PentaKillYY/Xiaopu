//
//  CommunityCollectTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CommunityCollectTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* communityTitle;
@property(nonatomic,weak)IBOutlet UILabel* communityUser;
@property(nonatomic,weak)IBOutlet UILabel* communityReplyNumber;

-(void)bingdingViewModel:(DataItem*)item;

@end
