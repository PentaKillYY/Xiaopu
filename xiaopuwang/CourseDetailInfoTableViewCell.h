//
//  CourseDetailInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SKTagView.h"
@interface CourseDetailInfoTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel* coursePrice;
@property(nonatomic,strong)IBOutlet SKTagView* courseTagView;
@property(nonatomic,weak)IBOutlet UILabel* courseNumber;
@property(nonatomic,weak)IBOutlet UILabel* courseTime;
@property(nonatomic,weak)IBOutlet UILabel* coursePeople;

-(void)bingdingViewModel:(DataResult*)result;
@end
