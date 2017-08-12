//
//  MyAboutInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyAboutInfoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* appLogo;
@property(nonatomic,weak)IBOutlet UILabel* appVersion;
@property(nonatomic,weak)IBOutlet UILabel* appContent;

-(void)setupCellContent;
@end
