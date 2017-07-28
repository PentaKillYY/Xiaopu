//
//  CouseDetailImageTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CouseDetailImageTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* courseImage;

-(void)bingdingViewModel:(DataResult*)result;
@end
