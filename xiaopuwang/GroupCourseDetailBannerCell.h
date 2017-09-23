//
//  GroupCourseDetailBannerCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GroupCourseDetailBannerCell : BaseTableViewCell
{
    NSTimer* timer;
    NSTimeInterval nowTimeInterval;
}
@property(nonatomic,weak)IBOutlet UIImageView* bannerLogo;
@property(nonatomic,weak)IBOutlet UILabel* courseNameLabel;
@property(nonatomic,weak)IBOutlet UILabel* countHourLabel;
@property(nonatomic,weak)IBOutlet UILabel* countMinLabel;
@property(nonatomic,weak)IBOutlet UILabel* countSecondLabel;
@property(nonatomic,weak)IBOutlet UILabel* groupPeopleLabel;
@property(nonatomic,weak)IBOutlet UILabel* courseStateLabel;

-(void)bingdingViewModel:(DataItem*)detailItem;

@end
