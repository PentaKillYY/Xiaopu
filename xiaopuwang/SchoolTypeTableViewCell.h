//
//  SchoolTypeTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface SchoolTypeTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* typeImage;
@property(nonatomic,weak)IBOutlet UILabel* typeName;
@property(nonatomic,weak)IBOutlet UILabel* typeCount;
@end
