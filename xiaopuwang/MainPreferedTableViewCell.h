//
//  MainPreferedTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MainPreferedTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* atitleView;
@property(nonatomic,weak)IBOutlet UIScrollView* scrollView;
@property(nonatomic,strong)DataResult* dataResult;
@end
