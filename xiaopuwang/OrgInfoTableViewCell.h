//
//  OrgInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgInfoTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel * orgDetail;
-(void)bingdingViewModel:(DataItem*)item;
@end
