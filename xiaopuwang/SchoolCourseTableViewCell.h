//
//  SchoolCourseTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SchoolCourseTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* courseName;

-(void)bingdingViewModel:(DataItem*)item;
@end
