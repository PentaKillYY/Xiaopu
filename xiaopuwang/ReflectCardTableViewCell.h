//
//  ReflectCardTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ReflectCardTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* cardName;
@property(nonatomic,weak)IBOutlet UILabel* cardNumber;
@property(nonatomic,weak)IBOutlet UIImageView* selectImage;

-(void)bingdingViewModel:(DataItem*)item;


@end

