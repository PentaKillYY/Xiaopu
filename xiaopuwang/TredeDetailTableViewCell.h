//
//  TredeDetailTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TredeDetailTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel* tradeOrderNumber;
@property(nonatomic,weak)IBOutlet UILabel* tradeContent;
@property(nonatomic,weak)IBOutlet UILabel* tradeTime;
@property(nonatomic,weak)IBOutlet UILabel* tradePrice;

-(void)bingdingViewModel:(DataItem*)item;
@end
