//
//  AdditionalTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/8.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeleteAdditionalCellDelegate <NSObject>

-(void)deleteAdditionalCell:(id)sender;

@end

@interface AdditionalTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel* addTitle;
@property(nonatomic,weak)IBOutlet UIButton* deleteButton;
@property(nonatomic,weak)IBOutlet UITextField* contentTextField;
@property(nonatomic,assign)id<DeleteAdditionalCellDelegate>delegate;

-(IBAction)deleteAction:(id)sender;
@end

