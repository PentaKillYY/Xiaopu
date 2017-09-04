//
//  MyCardTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol DeleteCardDelegate <NSObject>

-(void)deleteCard:(id)sender;

@end

@interface MyCardTableViewCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UILabel* cardName;
@property(nonatomic,weak)IBOutlet UILabel* cardLastNumber;
@property(nonatomic,weak)IBOutlet UIImageView* cardImage;
@property(nonatomic,weak)IBOutlet UIButton* cancelButton;
@property(nonatomic,weak)IBOutlet UIView* cardBGView;
@property(nonatomic,weak)IBOutlet UILabel* circle;
@property(nonatomic,assign)id<DeleteCardDelegate>delegate;

-(IBAction)deleteCardAction:(id)sender;
-(void)bingdingViewModel:(DataItem*)item;
@end

