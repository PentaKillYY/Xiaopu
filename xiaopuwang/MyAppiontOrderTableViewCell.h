//
//  MyAppiontOrderTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol AppointCellDelegate <NSObject>

-(void)deleteOrderDelegate:(id)sender;
-(void)dealOrderDelegate:(id)sender;
@end

@interface MyAppiontOrderTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UILabel* appointState;
@property(nonatomic,weak)IBOutlet UILabel* orgChineseName;
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgContent;
@property(nonatomic,weak)IBOutlet UILabel* orgDistance;
@property(nonatomic,weak)IBOutlet UIButton* cancelOrderButton;
@property(nonatomic,weak)IBOutlet UIButton* dealOrderButton;
@property(nonatomic,assign)id<AppointCellDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;

-(IBAction)deleteOrderAction:(id)sender;
-(IBAction)dealOrderAction:(id)sender;
@end

