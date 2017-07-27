//
//  VideoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface VideoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* videoLogo;
@property(nonatomic,weak)IBOutlet UILabel* videoName;

-(void)bingdingViewModel:(DataItem*)item;
@end
