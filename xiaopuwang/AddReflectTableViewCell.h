//
//  AddReflectTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReflectCardDelegate <NSObject>

-(void)addCardDelegate:(id)sender;

@end

@interface AddReflectTableViewCell : UITableViewCell
@property(nonatomic,assign)id<ReflectCardDelegate>delegate;
-(IBAction)addBankCardAction:(id)sender;
@end
