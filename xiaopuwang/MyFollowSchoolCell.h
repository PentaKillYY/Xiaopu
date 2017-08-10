//
//  MyFollowSchoolCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "SKTagView.h"
@interface MyFollowSchoolCell : MGSwipeTableCell
@property(nonatomic,weak)IBOutlet UILabel* schoolName;
@property(nonatomic,weak)IBOutlet UILabel* schoolEnglishName;
@property(nonatomic,strong)IBOutlet SKTagView* schoolClassView;
@property(nonatomic,weak)IBOutlet UILabel* posotion;
@property(nonatomic,weak)IBOutlet UIImageView* logoView;
-(void)bingdingViewModel:(DataItem*)item;
@end
