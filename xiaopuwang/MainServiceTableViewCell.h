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
@property (nonatomic,weak)IBOutlet UIButton* orgBtn;
@property (nonatomic,weak)IBOutlet UIButton* chinaSchoolBtn;
@property (nonatomic,weak)IBOutlet UIButton* overseaSchoolBtn;
@property (nonatomic,weak)IBOutlet NSLayoutConstraint* leadingSpace;
@property (nonatomic,weak)IBOutlet NSLayoutConstraint* trainingSpace;
@property (nonatomic,weak)IBOutlet NSLayoutConstraint* sepHeight;

@property (nonatomic,assign)id<ServiceDelegate>delegate;

-(IBAction)serviceAction:(id)sender;

@end

