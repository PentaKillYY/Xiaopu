//
//  MyTableCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyTableCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* cellTitle;
@property(nonatomic,weak)IBOutlet UIImageView* cellImage;
@property(nonatomic,weak)IBOutlet UILabel* cellDetail;
@end
