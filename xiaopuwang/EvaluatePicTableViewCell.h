//
//  EvaluatePicTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol EvaluatePicCellDelegate <NSObject>

-(void)takePicDelegate:(id)sender;
-(void)deletePicDelegate:(id)sender;

@end

@interface EvaluatePicTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* leftButton;

@property(nonatomic,assign)id<EvaluatePicCellDelegate>delegate;

@property(nonatomic,weak)IBOutlet UIButton* leftDeleteButton;

-(IBAction)takePicAction:(id)sender;
-(IBAction)deletePicAction:(id)sender;
@end

