//
//  SchoolBannerTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol BannerDelegate <NSObject>

-(void)bannerBubttonClicked:(id)sender;

@end

@interface SchoolBannerTableViewCell : BaseTableViewCell
@property (nonatomic,weak)IBOutlet UIButton* button1;
@property (nonatomic,weak)IBOutlet UIButton* button2;
@property (nonatomic,weak)IBOutlet UIButton* button3;
@property (nonatomic,weak)IBOutlet UIButton* button4;
@property (nonatomic,weak)IBOutlet UIButton* button5;
@property (nonatomic,weak)IBOutlet UIButton* button6;
@property (nonatomic,weak)IBOutlet UIButton* button7;
@property (nonatomic,weak)IBOutlet UIButton* button8;
@property (nonatomic,weak)IBOutlet NSLayoutConstraint* sepH;

@property (nonatomic,assign)id<BannerDelegate>delegate;

-(IBAction)clickButton:(id)sender;
@end
