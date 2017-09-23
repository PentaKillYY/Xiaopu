//
//  GroupCourseAdwardInfoTableViewCell.h
//  xiaopuwang
//se
//  Created by TonyJiang on 2017/9/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GroupCourseAdwardInfoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* nameLabel;
@property(nonatomic,weak)IBOutlet UILabel* orderId;
@property(nonatomic,weak)IBOutlet UILabel* phoneLabel;

-(void)bingdingViewModel:(DataItem*) adwardItem;
@end
