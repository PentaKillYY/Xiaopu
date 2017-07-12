//
//  MainRollingTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AutoRollingScrollView.h"
@interface MainRollingTableViewCell : BaseTableViewCell
{
    AutoRollingScrollView* scrollView;
}
@property(nonatomic,weak)IBOutlet UIImageView* logoImage;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* lineH;
@end
