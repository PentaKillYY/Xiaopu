//
//  MyPayTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol PayCellDelegate <NSObject>

-(void)payDelegate:(id)sender;
-(void)cancelDelegate:(id)sender;

@end

@interface MyPayTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UILabel* appointState;
@property(nonatomic,weak)IBOutlet UILabel* orgChineseName;
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgContent;
@property(nonatomic,weak)IBOutlet UILabel* orgDistance;
@property(nonatomic,weak)IBOutlet UIButton* cancelOrderButton;
@property(nonatomic,weak)IBOutlet UIButton* dealOrderButton;
@property(nonatomic,weak)IBOutlet UILabel* studentName;
@property(nonatomic,weak)IBOutlet UILabel* orderID;
@property(nonatomic,weak)IBOutlet UILabel* originPrice;
@property(nonatomic,weak)IBOutlet UILabel* realPrice;
@property(nonatomic,weak)IBOutlet UILabel* totalPrice;
@property(nonatomic,assign)id<PayCellDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;

-(IBAction)cancelOrderAction:(id)sender;
-(IBAction)PayOrderAction:(id)sender;
@end

