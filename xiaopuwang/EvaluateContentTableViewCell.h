//
//  EvaluateContentTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface EvaluateContentTableViewCell : BaseTableViewCell<UITextViewDelegate>
@property(nonatomic,weak)IBOutlet UITextView* contentTextView;
@end
