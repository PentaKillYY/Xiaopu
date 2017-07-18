//
//  ActivityTextFieldCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ActivityTextFieldCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* cellTitle;
@property(nonatomic,weak)IBOutlet UILabel* subTitle;
@property(nonatomic,weak)IBOutlet UITextField* contentTextField;
@end
