//
//  InviteRuleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteRuleTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* commonLabel;

@property(nonatomic,weak)IBOutlet UILabel* ruleTitle;

-(void)bingdingViewModel;
@end
