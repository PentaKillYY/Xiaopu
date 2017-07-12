//
//  MainCycleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SDCycleScrollView.h"

@interface MainCycleTableViewCell : BaseTableViewCell<SDCycleScrollViewDelegate>
@property(nonatomic,strong)IBOutlet SDCycleScrollView* cycleScrollView;

@end
