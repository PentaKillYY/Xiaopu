//
//  MainTypeTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/5.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainTypeDelegate <NSObject>

-(void)selectMainTypeDelegate:(id)sender;

@end

@interface MainTypeTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIButton* oneButton;
@property(nonatomic,weak)IBOutlet UIButton* twoButton;
@property(nonatomic,weak)IBOutlet UIButton* threeButton;
@property(nonatomic,weak)IBOutlet UIButton* fourButton;
@property(nonatomic,weak)IBOutlet UIButton* fiveButton;
@property(nonatomic,weak)IBOutlet UIButton* sixButton;
@property(nonatomic,weak)IBOutlet UIButton* sevenButton;
@property(nonatomic,weak)IBOutlet UIButton* eightButton;
@property(nonatomic,weak)IBOutlet UIButton* nineButton;
@property(nonatomic,weak)IBOutlet UIButton* tenButton;

@property(nonatomic,weak)IBOutlet UILabel* oneLabel;
@property(nonatomic,weak)IBOutlet UILabel* twoLabel;
@property(nonatomic,weak)IBOutlet UILabel* threeLabel;
@property(nonatomic,weak)IBOutlet UILabel* fourLabel;
@property(nonatomic,weak)IBOutlet UILabel* fiveLabel;
@property(nonatomic,weak)IBOutlet UILabel* sixLabel;
@property(nonatomic,weak)IBOutlet UILabel* sevenLabel;
@property(nonatomic,weak)IBOutlet UILabel* eightLabel;
@property(nonatomic,weak)IBOutlet UILabel* nineLabel;
@property(nonatomic,weak)IBOutlet UILabel* tenLabel;

@property(nonatomic,assign)id<MainTypeDelegate>delegate;

-(IBAction)clickTypeAction:(id)sender;

-(void)setupUI;
@end

