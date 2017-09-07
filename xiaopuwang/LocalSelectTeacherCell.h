//
//  LocalSelectTeacherCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LocalSelectTeacherCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* teacherName;
@property(nonatomic,weak)IBOutlet UILabel* teacherOrg;
@property(nonatomic,weak)IBOutlet UILabel* teacherCareer;
@property(nonatomic,weak)IBOutlet UILabel* teacherIntro;
@property(nonatomic,weak)IBOutlet UIImageView* teacherLogo;

-(void)bingdingViewModel:(DataItem*)item;
@end
