//
//  OrgMoreStudentTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/13.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgMoreStudentTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* studentLogo;
@property(nonatomic,weak)IBOutlet UILabel* studentName;
@property(nonatomic,weak)IBOutlet UILabel* studentContent;

-(void)bingdingViewModel:(DataItem*)item;
@end
