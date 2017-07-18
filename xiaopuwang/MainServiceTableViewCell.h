//
//  MainServiceTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol ServiceDelegate <NSObject>

-(void)pushToServicePage:(id)sender;

@end

@interface MainServiceTableViewCell : BaseTableViewCell
@property (nonatomic,weak)IBOutlet UIButton* specialistBtn;
@property (nonatomic,weak)IBOutlet UIButton* personalBtn;
@property (nonatomic,weak)IBOutlet UILabel* bottomLine;
@property (nonatomic,weak)IBOutlet UILabel* topLine;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint* lineH;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint* lineH2;
@property (nonatomic,assign)id<ServiceDelegate>delegate;

-(IBAction)serviceAction:(id)sender;

@end

