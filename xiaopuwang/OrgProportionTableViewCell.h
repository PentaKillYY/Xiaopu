//
//  OrgProportionTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UUChart.h"
@interface OrgProportionTableViewCell : BaseTableViewCell<UUChartDataSource>{
    UUChart *chartView;
    DataItem* sourceitem;
}

-(void)bingdingViewModel:(DataItem*)item;

@end
