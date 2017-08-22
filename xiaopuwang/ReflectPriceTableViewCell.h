//
//  ReflectPriceTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReflectPriceTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* balanceLabel;

-(void)bingdingViewModel;
@end
