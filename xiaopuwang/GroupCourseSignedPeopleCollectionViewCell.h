//
//  GroupCourseSignedPeopleCollectionViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCourseSignedPeopleCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView* userLogoView;
@property(nonatomic,weak)IBOutlet UILabel* userName;
-(void)bingdingViewModel:(DataItem*)item;
@end
