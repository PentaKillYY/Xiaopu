//
//  MyCouponSimpleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyCouponSimpleTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* couponTitle;
@property(nonatomic,weak)IBOutlet UIImageView* couponSelectImage;
@end

