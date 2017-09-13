//
//  OrgTitleClassTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol OrgTitleClassDelegate <NSObject>

-(void)moreClassDelegate:(id)sender;

@end

@interface OrgTitleClassTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* className;
@property(nonatomic,weak)IBOutlet UILabel* classinfo;
@property(nonatomic,weak)IBOutlet UIImageView* classLogo;
@property(nonatomic,weak)IBOutlet UILabel* classTarget;
@property(nonatomic,weak)IBOutlet UIImageView* classTargetLogo;
@property(nonatomic,assign)id<OrgTitleClassDelegate>delegate;

-(void)bingdingVieModel:(DataItem*)item;
-(IBAction)moreClassAction:(id)sender;
@end

