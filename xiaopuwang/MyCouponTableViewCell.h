//
//  MyCouponTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Dashline.h"
@protocol CouponDetailDelegate <NSObject>

-(void)changeDetailShowDelegate:(id)sender;

@end

@interface MyCouponTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* couponNumber;
@property(nonatomic,weak)IBOutlet UILabel* couponNuit;
@property(nonatomic,weak)IBOutlet UILabel* couponDesc;
@property(nonatomic,weak)IBOutlet UILabel* couponName;
@property(nonatomic,weak)IBOutlet UILabel* couponTime;
@property(nonatomic,weak)IBOutlet UIButton* couponDetail;
@property(nonatomic,weak)IBOutlet UIImageView* couponBackImage;
@property(nonatomic,weak)IBOutlet UIImageView* arrowImage;
@property(nonatomic,weak)IBOutlet UIView* bgView;
@property(nonatomic,assign)id<CouponDetailDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;
-(IBAction)couponDetailAction:(id)sender;
@end

