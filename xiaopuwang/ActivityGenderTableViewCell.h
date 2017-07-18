//
//  ActivityGenderTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "RadioButton.h"

@interface ActivityGenderTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet RadioButton* radio1;
@property(nonatomic,weak)IBOutlet RadioButton* radio2;

@end
