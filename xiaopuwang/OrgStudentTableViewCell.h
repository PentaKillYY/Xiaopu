//
//  OrgStudentTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrgStudentTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* studentLogo;
@property(nonatomic,weak)IBOutlet UILabel* studentName;
@property(nonatomic,weak)IBOutlet UILabel* studentContent;

-(void)bingdingViewModel:(DataItem*)item;
@end
