//
//  CommunityReplyCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CommunityReplyCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* replyLogo;
@property(nonatomic,weak)IBOutlet UILabel* replyUserName;
@property(nonatomic,weak)IBOutlet UILabel* replyTime;
@property(nonatomic,weak)IBOutlet UILabel* replyContent;
@property(weak, nonatomic)IBOutlet NSLayoutConstraint *replyImageHeight;
@property(nonatomic,weak)IBOutlet UIImageView* replyImageOne;
@property(nonatomic,weak)IBOutlet UIImageView* replyImageTwo;
@property(nonatomic,weak)IBOutlet UIImageView* replyImageThree;

-(void)bingdingViewModel:(DataItem*)item;
@end
