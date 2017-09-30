//
//  InvitePeopleBottomTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitePeopleBottomTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* commonLabel;
@property(nonatomic,weak)IBOutlet UILabel* phoneLabel;
@property(nonatomic,weak)IBOutlet UILabel* timeLabel;

-(void)bingdingViewModel:(DataItem*)item;
@end
