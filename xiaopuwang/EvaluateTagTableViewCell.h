//
//  EvaluateTagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol EvaluateTagCellDelegate <NSObject>

-(void)evaluateTagDelegate:(id)sender;

@end

@interface EvaluateTagTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* goodButton;
@property(nonatomic,weak)IBOutlet UIButton* middleButton;
@property(nonatomic,weak)IBOutlet UIButton* badButton;

@property(nonatomic,assign)id<EvaluateTagCellDelegate>delegate;

-(IBAction)clickButton:(id)sender;
@end

