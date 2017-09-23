//
//  GroupCourseCollectionViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCourseCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView* groupCourseLogo;
@property(nonatomic,weak)IBOutlet UILabel* courseName;
@property(nonatomic,weak)IBOutlet UILabel* originPrice;
@property(nonatomic,weak)IBOutlet UILabel* groupPrice;
@property(nonatomic,weak)IBOutlet UILabel* totalPeople;
@property(nonatomic,weak)IBOutlet UILabel* currentPeople;
@property(nonatomic,weak)IBOutlet UIImageView* peopleLogo;
@property(nonatomic,weak)IBOutlet UILabel* groupCourseStateLabel;
@property(nonatomic,weak)IBOutlet UILabel* trainingCorner;

-(void)bingdingViewModel:(DataItem*)item;
@end
