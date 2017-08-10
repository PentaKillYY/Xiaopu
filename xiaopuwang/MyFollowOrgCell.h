//
//  MyFollowOrgCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "StarRatingView.h"

@interface MyFollowOrgCell : MGSwipeTableCell
@property(nonatomic,weak)IBOutlet UIImageView* logoView;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UILabel* orgContent;
@property(nonatomic,weak)IBOutlet UILabel* distance;
@property(nonatomic,weak)IBOutlet StarRatingView* starView;

-(void)bingdinViewModel:(DataItem*)item;
@end
