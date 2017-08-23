//
//  MyCouponDetailTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCouponDetailDelegate <NSObject>

-(void)giveAnotherDelegate:(id)sender;

@end

@interface MyCouponDetailTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* detailContent;
@property(nonatomic,weak)IBOutlet UIButton* giveToAnother;
@property(nonatomic,weak)IBOutlet UIView* bgView;
@property(nonatomic,assign)id<MyCouponDetailDelegate>delegate;

-(IBAction)giveAnotherAction:(id)sender;

-(void)bingdingViewModel:(NSString*)detailText;
@end

