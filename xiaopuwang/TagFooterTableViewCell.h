//
//  TagFooterTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectButtonDelegate <NSObject>

-(void)clearDelegate:(id)sender;
-(void)confirmDelegate:(id)sender;

@end

@interface TagFooterTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIButton* clearBtn;
@property(nonatomic,weak)IBOutlet UIButton* resetBtn;
@property(nonatomic,assign)id<SelectButtonDelegate>delegate;

-(IBAction)clearButtonAction:(id)sender;
-(IBAction)confirmButtonAction:(id)sender;

@end

