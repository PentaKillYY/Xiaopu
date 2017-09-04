//
//  PayTypeTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol PayTypeCellDelegate <NSObject>

-(void)payTypeDelegate:(id)sender;

@end

@interface PayTypeTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UIButton* aliPayButton;
@property(nonatomic,weak)IBOutlet UIButton* wxPayButton;
@property(nonatomic,assign)id<PayTypeCellDelegate>delegate;

-(IBAction)alipaySelectAction:(id)sender;
-(IBAction)wxPaySelectAction:(id)sender;
@end

