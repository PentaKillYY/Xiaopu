//
//  MySpecialistTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MySpecialistTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* spTime;
@property(nonatomic,weak)IBOutlet UILabel* spProjname;
@property(nonatomic,weak)IBOutlet UILabel* spRemarks;
@property(nonatomic,weak)IBOutlet UILabel* spState;

-(void)bingdingViewModelTypeName:(NSString*)type State:(NSInteger)state Time:(NSString*)time;
@end
