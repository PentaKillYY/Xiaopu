//
//  MyReplyCOmmunityTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyReplyCOmmunityTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UIImageView* replyUserLogo;
@property(nonatomic,weak)IBOutlet UILabel* replyUserName;
@property(nonatomic,weak)IBOutlet UILabel* replyTime;
@property(nonatomic,weak)IBOutlet UILabel* replyContent;
@property(nonatomic,weak)IBOutlet UILabel* replyTitle;
@property(nonatomic,weak)IBOutlet UIView* replyBgView;

-(void)bingdingViewModel:(DataItem*)item;
@end
