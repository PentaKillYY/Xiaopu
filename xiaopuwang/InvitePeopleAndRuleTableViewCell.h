//
//  InvitePeopleAndRuleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HMSegmentedControl.h"

@interface InvitePeopleAndRuleTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet HMSegmentedControl* segmentedControl;
@property(nonatomic,weak)IBOutlet UILabel* topSep;
@end
