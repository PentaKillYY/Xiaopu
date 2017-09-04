//
//  TextFieldTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/19.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface TextFieldTableViewCell : BaseTableViewCell
@property (nonatomic,weak)IBOutlet UITextField* contentField;
@property (nonatomic,weak)IBOutlet UILabel* contentTitle;

@end
