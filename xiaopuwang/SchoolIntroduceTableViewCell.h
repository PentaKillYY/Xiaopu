//
//  SchoolIntroduceTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface SchoolIntroduceTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel * schoolDetail;
@property(nonatomic,weak)IBOutlet UILabel* schoolIntro;
@property(nonatomic,weak)IBOutlet UILabel* indicatorLabel;
-(void)bingdingViewModel:(DataItem*)item;
@end
