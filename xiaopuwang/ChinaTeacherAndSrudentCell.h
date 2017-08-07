//
//  ChinaTeacherAndSrudentCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ChinaTeacherAndSrudentCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* logoView;
@property(nonatomic,weak)IBOutlet UILabel* nameLabel;
@property(nonatomic,weak)IBOutlet UILabel* infoLabel;

-(void)bingdingViewModel:(DataItem*)item;
@end
