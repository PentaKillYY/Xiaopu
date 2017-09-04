//
//  TextViewTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/19.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface TextViewTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UITextView* contentTextView;
@property(nonatomic,weak)IBOutlet UILabel* contentTitle;
@end
