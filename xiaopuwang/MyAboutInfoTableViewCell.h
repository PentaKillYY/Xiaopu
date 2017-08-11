//
//  MyAboutInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAboutInfoTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* appLogo;
@property(nonatomic,weak)IBOutlet UILabel* appVersion;
@property(nonatomic,weak)IBOutlet UILabel* appContent;

-(void)setupCellContent;
@end
