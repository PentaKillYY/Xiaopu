//
//  TagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SKTagView.h"

@interface TagTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* tagType;
@property(nonatomic,strong)IBOutlet SKTagView* tagView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* tagH;
@end
