//
//  MySettingTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MySettingTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* cellTitle;
@property(nonatomic,weak)IBOutlet UILabel* cellDetail;
@end
