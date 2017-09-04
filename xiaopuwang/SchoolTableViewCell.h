//
//  SchoolTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SKTagView.h"
@interface SchoolTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgContent;
@property(nonatomic,strong)IBOutlet SKTagView* orgClassView;
@property(nonatomic,weak)IBOutlet UILabel* distance;
@property(nonatomic,weak)IBOutlet UILabel* sepLabel;
@property(nonatomic,weak)IBOutlet UILabel* leftTag;
@property(nonatomic,weak)IBOutlet UILabel* middleTag;
@property(nonatomic,weak)IBOutlet UILabel* rightTag;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* sepH;

-(void)bingdingViewModel:(DataItem*)item;
@end
