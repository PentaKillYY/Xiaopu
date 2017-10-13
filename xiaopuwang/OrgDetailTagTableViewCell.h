//
//  OrgDetailTagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgDetailTagTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* leftTag;
@property(nonatomic,weak)IBOutlet UILabel* middleTag;
@property(nonatomic,weak)IBOutlet UILabel* rightTag;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* leftTagW;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* middleTagW;
-(void)bingdingViewModel:(DataItem*)item;
-(void)bingdingGroupCourseModel:(BOOL)isGroupCourse;
@end
