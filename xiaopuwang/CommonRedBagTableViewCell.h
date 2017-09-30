//
//  CommonRedBagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CommonRedBagTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel* bagPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* bagPriceUnitLabel;
@property(nonatomic,weak)IBOutlet UILabel* bagEndTimeLabel;
@property(nonatomic,weak)IBOutlet UIImageView* bagTipImage;
@property(nonatomic,weak)IBOutlet UIImageView* bagLogoImage;
@property(nonatomic,weak)IBOutlet UIButton* useButton;

-(void)setupred;
-(void)setupgray;
-(void)bingdingViewModel:(DataItem*)item;
@end
