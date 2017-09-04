//
//  PostCommunityTypeCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PostCommunityTypeCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* typeImage;
@property(nonatomic,weak)IBOutlet UILabel* typeName;
@property(nonatomic,weak)IBOutlet UILabel* typeDetail;
@end
