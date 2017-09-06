//
//  LocalSelectSchoolCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "InnerLabel.h"
@interface LocalSelectSchoolCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* schoolLogo;
@property(nonatomic,weak)IBOutlet UILabel* schoolName;
@property(nonatomic,weak)IBOutlet InnerLabel* leftTag;
@property(nonatomic,weak)IBOutlet InnerLabel* middleTag;
@property(nonatomic,weak)IBOutlet InnerLabel* rightTag;
@property(nonatomic,weak)IBOutlet UILabel* schoolEngName;
@property(nonatomic,weak)IBOutlet UILabel* schoolCourse;
@property(nonatomic,weak)IBOutlet UILabel* schoolDistrict;

-(void)bingdingViewModel:(DataItem*)item;
@end
