//
//  OrgAlbumVideoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrgAlbumVideoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* orgTitle;
@property(nonatomic,weak)IBOutlet UIScrollView* contentScroll;

- (void)setupUI:(DataResult*)dataresult Type:(NSInteger)albumType;
@end
