//
//  SchoolDetailTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SKTagView.h"

@interface SchoolDetailTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* schoolLogo;
@property(nonatomic,weak)IBOutlet UILabel* chineseName;
@property(nonatomic,weak)IBOutlet UILabel* englishName;
@property(nonatomic,strong)IBOutlet SKTagView* orgClassView;
@property(nonatomic,weak)IBOutlet UILabel* schoolAddress;
@property(nonatomic,weak)IBOutlet UILabel* schoolWebsite;

-(void)bingdingViewModel:(DataItem*)item;
@end
