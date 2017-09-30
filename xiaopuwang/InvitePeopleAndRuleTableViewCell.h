//
//  InvitePeopleAndRuleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HMSegmentedControl.h"
@protocol InvitePeopleAndRuleDelegate <NSObject>

-(void)changeSeg:(NSInteger)segInedx;

@end

@interface InvitePeopleAndRuleTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet HMSegmentedControl* segmentedControl;
@property(nonatomic,weak)IBOutlet UILabel* topSep;
@property(nonatomic,assign)id<InvitePeopleAndRuleDelegate>delegate;
@end

