//
//  OrgHouseRateTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PNChart.h"

@interface OrgHouseRateTableViewCell : BaseTableViewCell
@property(nonatomic,strong) PNPieChart* pieChart;
@property(nonatomic,weak)IBOutlet UILabel* totalLabel;

-(void)bingdingViewModel:(DataItem*)item;
@end
