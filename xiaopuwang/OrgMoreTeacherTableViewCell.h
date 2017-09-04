//
//  OrgMoreTeacherTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SKTagView.h"

@interface OrgMoreTeacherTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* teacherLogo;
@property(nonatomic,weak)IBOutlet UILabel* teacherName;
@property(nonatomic,weak)IBOutlet UILabel* teacherGoodCourse;
@property(nonatomic,weak)IBOutlet UILabel* teacherInfo;
@property(nonatomic,weak)IBOutlet UILabel* teacherBackground;
@property(nonatomic,strong)IBOutlet SKTagView* teacherTagView;
@property(nonatomic,weak)IBOutlet UILabel* teacherCareer;
-(void)bingdingViewModel:(DataItem*)item;
@end
