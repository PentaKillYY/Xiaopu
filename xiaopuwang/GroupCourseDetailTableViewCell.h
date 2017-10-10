//
//  GroupCourseDetailTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCourseDetailTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView* courseLogo;
@property(nonatomic,weak)IBOutlet UILabel* courseNameLabel;
@property(nonatomic,weak)IBOutlet UILabel* groupPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* saveLabel;
@property(nonatomic,weak)IBOutlet UILabel* groupStateLabel;
@property(nonatomic,weak)IBOutlet UILabel* groupNameLabel;
-(void)bingdingViewModel:(DataItem*)item;

@end
