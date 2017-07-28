//
//  CourseDetailContentTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CourseDetailContentTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* courseContent;

-(void)bingdingViewModel:(DataResult*)result;
@end
