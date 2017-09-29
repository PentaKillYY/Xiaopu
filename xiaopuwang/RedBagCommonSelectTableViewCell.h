//
//  RedBagCommonSelectTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface RedBagCommonSelectTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* bagPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* bagPriceUnitLabel;
@property(nonatomic,weak)IBOutlet UILabel* bagEndTimeLabel;
@property(nonatomic,weak)IBOutlet UIImageView* bagTipImage;
@property(nonatomic,weak)IBOutlet UIImageView* bagLogoImage;
@property(nonatomic,weak)IBOutlet UIButton* selectStateButton;
-(void)setupred;
-(void)bingdingViewModel:(DataItem*)item;
@end
