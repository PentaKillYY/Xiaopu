//
//  SchoolGradeTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SchoolGradeTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIScrollView* gradeScrollView;

-(void)bingdingViewModel:(DataItem*)item;
@end
