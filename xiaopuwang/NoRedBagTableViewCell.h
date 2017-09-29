//
//  NoRedBagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface NoRedBagTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UIView* redBG;
@property(nonatomic,weak)IBOutlet UIButton* selectStateButton;
@end
