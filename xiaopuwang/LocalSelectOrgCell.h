//
//  LocalSelectOrgCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StarRatingView.h"
#import "InnerLabel.h"

@interface LocalSelectOrgCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* logoView;
@property(nonatomic,weak)IBOutlet StarRatingView* starView;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet InnerLabel* leftTag;
@property(nonatomic,weak)IBOutlet InnerLabel* rightTag;
@property(nonatomic,weak)IBOutlet UILabel* orgDistance;
@property(nonatomic,weak)IBOutlet UILabel* teachCourse;
@property(nonatomic,weak)IBOutlet UILabel* orgDistrict;

-(void)bingdingViewModel:(DataItem*)item;
@end
