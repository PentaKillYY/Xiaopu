//
//  PostCommunityContentCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PlaceholderTextView.h"
@interface PostCommunityContentCell : BaseTableViewCell<UITextViewDelegate>
@property(nonatomic,weak)IBOutlet PlaceholderTextView* contentTextView;
@property(nonatomic,weak)IBOutlet UILabel* textLength;
@end
