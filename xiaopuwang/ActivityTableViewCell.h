//
//  ActivityTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface ActivityTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* activityTime;
@property(nonatomic,weak)IBOutlet UILabel* activityState;
@property(nonatomic,weak)IBOutlet UIImageView* activityImage;
@end
