//
//  OrgEvaluateTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StarRatingView.h"

@interface OrgEvaluateTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet StarRatingView* starView;
@property(nonatomic,weak)IBOutlet UILabel* nameLabel;
@property(nonatomic,weak)IBOutlet UILabel* relyContent;
@property(nonatomic,weak)IBOutlet UIImageView* logoImage;

-(void)bingdingViewModel:(DataItem*)item;
@end
