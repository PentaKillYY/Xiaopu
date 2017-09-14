//
//  OrgDetailEvaluateTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgDetailEvaluateTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* evaluateNumber;

-(void)bingdingViewModel:(DataResult*)result;
@end
