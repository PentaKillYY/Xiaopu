//
//  LocalSelectTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol LocalSelectDelegate <NSObject>

-(void)localSelectChangeDelegate:(id)sender;

@end

@interface LocalSelectTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* teacherButton;
@property(nonatomic,weak)IBOutlet UIButton* orgButton;
@property(nonatomic,weak)IBOutlet UIButton* interSchoolButton;
@property(nonatomic,weak)IBOutlet UIButton* chinaSchoolButton;
@property(nonatomic,assign)id<LocalSelectDelegate>delegate;

-(IBAction)selectTagAction:(id)sender;
@end

