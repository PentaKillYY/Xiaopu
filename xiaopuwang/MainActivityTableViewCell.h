//
//  MainActivityTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MainActivityTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* atitleImage;
@property(nonatomic,weak)IBOutlet UIImageView* acontentImage;
@property(nonatomic,strong)IBOutlet NSLayoutConstraint* tHeight;
@property(nonatomic,strong)IBOutlet NSLayoutConstraint* cHeight;
@end
